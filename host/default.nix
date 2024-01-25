{lib, ...}: {
  imports = [
    ./intel.nix
    ./hardware-configuration.nix
  ];

  time.timeZone = lib.mkDefault "Europe/Berlin";

  networking.hostName = "linix";
}
