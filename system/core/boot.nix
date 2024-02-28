{
  pkgs,
  lib,
  inputs,
  ...
}: {
  environment.systemPackages = [inputs.chaotic.packages.x86_64-linux.scx];
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
    #kernelPackages = pkgs.linuxPackages_latest;

    kernelPackages = lib.mkForce inputs.chaotic.packages.x86_64-linux.linuxPackages_cachyos;
    loader = {
      # systemd-boot on UEFI
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
}
