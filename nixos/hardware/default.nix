{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./opengl.nix
    ./bluetooth.nix
    ./brillo.nix
  ];
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    lm_sensors
    # system tools
    sysstat
    pciutils # lspci
    usbutils # lsusb
    hdparm # for disk performance, command
    dmidecode # a tool that reads information about your system's hardware from the BIOS according to the SMBIOS/DMI standard
  ];
}
