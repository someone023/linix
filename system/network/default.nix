{
  lib,
  pkgs,
  ...
}:
# networking configuration
{
  imports = [./security.nix];

  networking = {
    useDHCP = lib.mkForce false;
    #interfaces.wlan0.useDHCP = lib.mkForce true;
    useNetworkd = lib.mkForce true;

    usePredictableInterfaceNames = lib.mkDefault true;

    wireless = {
      userControlled.enable = true;
      iwd = {
        enable = true;
        settings = {
          Settings = {
            AutoConnect = true;
          };
          General = {
            AddressRandomization = "network";
            AddressRandomizationRange = "full";
            EnableNetworkConfiguration = true;
            RoamRetryInterval = 15;
          };
          Network = {
            EnableIPv6 = true;
          };
        };
      };
    };
  };

  systemd.network.wait-online.enable = false;

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
}
