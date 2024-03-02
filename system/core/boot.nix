{
  pkgs,
  lib,
  inputs,
  ...
}: {
  boot = {
    kernelParams = lib.mkAfter ["noquiet"];
    tmp = {
      cleanOnBoot = true;
      useTmpfs = false;
    };
    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["ext4" "btrfs" "vfat"];
    };

    # use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      # systemd-boot on UEFI
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
}
