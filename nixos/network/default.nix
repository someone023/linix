{lib, ...}:
# networking configuration
{
  networking.wireless.iwd.enable = true;

  #networking.networkmanager = {
  #  enable = true;
  #  wifi.backend = "iwd";
  #};

  services = {
    openssh = {
      enable = true;
      settings = {
        #UseDns = true;
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
    #resolved.enable = true;
  };
}
