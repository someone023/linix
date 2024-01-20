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

    ./impermanence.nix
  ];

  time.timeZone = lib.mkDefault "Europe/Berlin";

  networking.hostName = "linix";
  documentation.dev.enable = true;

  i18n = let
    defaultLocale = "en_US.UTF-8";
    de = "de_DE.utf8";
  in {
    inherit defaultLocale;
    extraLocaleSettings = {
      LANG = defaultLocale;
      LC_COLLATE = defaultLocale;
      LC_CTYPE = defaultLocale;
      LC_MESSAGES = defaultLocale;

      LC_ADDRESS = de;
      LC_IDENTIFICATION = de;
      LC_MEASUREMENT = de;
      LC_MONETARY = de;
      LC_NAME = de;
      LC_NUMERIC = de;
      LC_PAPER = de;
      LC_TELEPHONE = de;
      LC_TIME = de;
    };
  };
}
