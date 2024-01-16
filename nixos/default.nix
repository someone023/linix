{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./sound.nix
    ./configuration.nix
  ];
}
