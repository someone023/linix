{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./bluetooth.nix
    ./brillo.nix
  ];

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
