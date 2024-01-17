{
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware
    ./services
    ./programs
    ./core
    ./network
    ./nix.nix
  ];

  time.timeZone = lib.mkDefault "Europe/Berlin";

  networking.hostName = "linix";
  documentation.dev.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
    ];
  };
}
