{
  lib,
  pkgs,
  ...
}:
# networking configuration
{
  imports = [./security.nix];

  networking = {
    wireless.iwd.enable = true;

    #useDHCP = false;
  };

  #networking.networkmanager = {
  #  enable = true;
  #  wifi.backend = "iwd";
  #};

  environment.systemPackages = with pkgs; [
    ethtool
    # dns client
    dogdns

    wget
    curl
  ];

  services = {
    openssh = {
      enable = true;
      settings = {
        #UseDns = true;
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
    resolved.enable = true;
  };
}
