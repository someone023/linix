{pkgs, ...}: {
  programs.zsh.enable = true;
  users.users = {
    wasd = {
      isNormalUser = true;
      hashedPassword = "$6$Oa4rGIfOC2.fPaZb$A4./GBWLPxyHO/nNs/yVJAHKP9Z2qZ.3QPaFwDf4NAMqYyXgtmkeGK7WN4qyEDfRwIAagEEt.SxgYDeYe6EGo/";
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINhqO14oVhYp3iAYnKH1h43czDOxy6C/zU0FRvTQ2MP9 ali"
      ];
      extraGroups = ["input" "libvirtd" "networkmanager" "plugdev" "transmission" "video" "wheel"];
    };
  };
}
