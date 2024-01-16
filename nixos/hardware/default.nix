{
  imports = [
    ./hardware-configuration.nix
    ./opengl.nix
    ./bluetooth.nix
  ];
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
}
