{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) forEach;
  wipeScript = ''

     mkdir -p /mnt

    # We first mount the btrfs root to /mnt
    # so we can manipulate btrfs subvolumes.
    mount -o subvol=/ /dev/disk/by-label/NIXOS /mnt

    btrfs subvolume list -o /mnt/root |
      cut -f9 -d' ' |
      while read subvolume; do
        echo "deleting /$subvolume subvolume..."
        btrfs subvolume delete "/mnt/$subvolume"
      done &&
      echo "deleting /root subvolume..." &&
      btrfs subvolume delete /mnt/root

    echo "restoring blank /root subvolume..."
    btrfs subvolume snapshot /mnt/root-blank /mnt/root

    # Once we're done rolling back to a blank snapshot,
    # we can unmount /mnt and continue on the boot process.
    umount /mnt
  '';
  phase1Systemd = config.boot.initrd.systemd.enable;
in {
  imports = [inputs.impermanence.nixosModule];

  environment.persistence."/persist" = {
    hideMounts = true;
    directories =
      [
        {
          directory = "/var/lib/iwd";
          mode = "u=rwx,g=,o=";
        }
      ]
      ++ forEach ["iwd" "systemd" "nix" "ssh"] (x: "/etc/${x}")
      ++ forEach ["pipewire" "sudo" "systemd"] (x: "/var/lib/${x}");
    files = ["/etc/machine-id"];
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
