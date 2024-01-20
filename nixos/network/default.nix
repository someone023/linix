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

    useDHCP = lib.mkForce false;
    interfaces.wlan0.useDHCP = lib.mkForce true;
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
