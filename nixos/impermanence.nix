{
  inputs,
  lib,
  ...
}: let
  inherit (lib) forEach;
in {
  imports = [inputs.impermanence.nixosModule];
  fileSystems."/etc/ssh" = {
    depends = ["/persist"];
    neededForBoot = true;
  };
  environment.persistence."/persist" = {
    hideMounts = true;
    directories =
      [
        # dirty fix for "no storage left on device" while rebuilding
        # it gets wiped anyway
        "/tmp"
        "/var/log"
        "/var/db/sudo"
      ]
      ++ forEach ["nixos" "iwd" "nix" "ssh" "secureboot"] (x: "/etc/${x}")
      ++ forEach ["iwd" "pipewire" "libvirt" "fail2ban"] (x: "/var/lib/${x}");
    files = ["/etc/machine-id"];
  };
}
