# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/2c710055-c66e-478e-bf54-197d88c78112";
    fsType = "btrfs";
    options = ["noatime" "discard" "subvol=root" "compress=zstd:1"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/2c710055-c66e-478e-bf54-197d88c78112";
    fsType = "btrfs";
    options = ["noatime" "discard" "subvol=nix" "compress=zstd:1"];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/2c710055-c66e-478e-bf54-197d88c78112";
    fsType = "btrfs";
    options = ["noatime" "discard" "subvol=persist" "compress=zstd:1"];
    neededForBoot = true;
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/2c710055-c66e-478e-bf54-197d88c78112";
    fsType = "btrfs";
    options = ["noatime" "discard" "subvol=log" "compress=zstd:1"];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E466-71C1";
    fsType = "vfat";
    options = ["noatime" "discard"];
  };
    
      swapDevices =
    [ { device = "/dev/disk/by-uuid/764eec4f-041c-4e86-9080-e43e601e951c"; }
    ];



  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
