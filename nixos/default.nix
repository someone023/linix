{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./services
    ./programs
    ./core
    ./sound.nix
    ./configuration.nix
    ./fonts.nix
  ];
}
