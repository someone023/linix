{
  pkgs,
  lib,
  inputs,
  outputs,
  self,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    # Include the results of the hardware scan.
    ./hardware
    ./services
    ./core
    ./network
    ./impermanence.nix
  ];

  home-manager = {
    verbose = true;
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs outputs self;};
    users = {
      wasd = import ../home;
    };
  };

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
