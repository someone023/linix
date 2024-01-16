{lib, ...}:
# networking configuration
{
  #networking.networkmanager.enable = true;

  networking.wireless.iwd.enable = true;

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
