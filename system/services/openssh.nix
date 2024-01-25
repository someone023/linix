{
  services = {
    openssh = {
      enable = true;
      openFirewall = true;
      startWhenNeeded = true;
      settings = {
        #UseDns = true;
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
      hostKeys = [
        {
          bits = 4096;
          path = "/etc/ssh/ssh_host_rsa_key";
          type = "rsa";
        }
        {
          bits = 4096;
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };
  };
}
