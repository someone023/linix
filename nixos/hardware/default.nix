{
  imports = [
    ./hardware-configuration.nix
    ./opengl.nix
    ./bluetooth.nix
    ./brillo.nix
  ];
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
}
