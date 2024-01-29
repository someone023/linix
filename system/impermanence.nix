{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) forEach;
  wipeScript = ''
    mkdir /tmp -p
    MNTPOINT=$(mktemp -d)
    (
      mount -t btrfs -o subvol=/ /dev/disk/by-label/NIXOS "$MNTPOINT"
      trap 'umount "$MNTPOINT"' EXIT

      echo "Creating needed directories"
      mkdir -p "$MNTPOINT"/persist/var/{log,lib/{nixos,systemd}}

      echo "Cleaning root subvolume"
      btrfs subvolume list -o "$MNTPOINT/root" | cut -f9 -d ' ' |
      while read -r subvolume; do
        btrfs subvolume delete "$MNTPOINT/$subvolume"
      done && btrfs subvolume delete "$MNTPOINT/root"

      echo "Restoring blank subvolume"
      btrfs subvolume snapshot "$MNTPOINT/root-blank" "$MNTPOINT/root"
    )
  '';
  phase1Systemd = config.boot.initrd.systemd.enable;
in {
  imports = [inputs.impermanence.nixosModule];

  environment.persistence."/persist" = {
    hideMounts = true;
    directories =
      [
        "/var/db/sudo"
      ]
      ++ forEach ["nixos" "iwd" "systemd" "nix" "ssh" "secureboot"] (x: "/etc/${x}")
      ++ forEach ["iwd" "pipewire" "libvirt" "systemd"] (x: "/var/lib/${x}");
    files = ["/etc/machine-id"];

    users.wasd = {
      directories =
        [
          "linix"
          "Downloads"
          "dev"
          {
            directory = ".gnupg";
            mode = "0700";
          }
          {
            directory = ".local/nix";
            mode = "0700";
          }
        ]
        ++ forEach ["nvim"] (
          x: ".config/${x}"
        )
        ++ forEach ["nix" "starship" "nix-index" "tealdeer" "mozilla"] (
          x: ".cache/${x}"
        )
        ++ forEach ["direnv" "keyrings" "nvim/lazy/nvim-treesitter/parser"] (x: ".local/share/${x}")
        ++ [".ssh" ".keepass" ".mozilla"];
    };
  };

  boot.initrd = {
    systemd.enable = true;
    supportedFilesystems = ["btrfs"];
    postDeviceCommands = lib.mkIf (!phase1Systemd) (lib.mkBefore wipeScript);
    systemd.services.restore-root = lib.mkIf phase1Systemd {
      description = "Rollback btrfs rootfs";
      wantedBy = ["initrd.target"];
      requires = [
        "dev-disk-by\\x2dlabel-NIXOS.device"
      ];
      after = [
        "dev-disk-by\\x2dlabel-NIXOS.device"
      ];
      before = ["sysroot.mount"];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = wipeScript;
    };
  };
}
