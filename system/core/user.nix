{
  pkgs,
  lib,
  ...
}: {
  programs.zsh.enable = true;
  users = {
    mutableUsers = false;
    users = {
      wasd = {
        isNormalUser = true;
        hashedPassword = "$6$Oa4rGIfOC2.fPaZb$A4./GBWLPxyHO/nNs/yVJAHKP9Z2qZ.3QPaFwDf4NAMqYyXgtmkeGK7WN4qyEDfRwIAagEEt.SxgYDeYe6EGo/";
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOgl64iFlij3ZrTaQHYVoP5Aa541gmBLUDwMRY4ZsF7p someone023"
        ];
        extraGroups = ["input" "libvirtd" "networkmanager" "plugdev" "transmission" "video" "wheel" "systemd-journal" "power" "nix"];
      };
    };
  };
  security.polkit.enable = true;
  systemd.enableUnifiedCgroupHierarchy = lib.mkForce true;
  environment.variables = {
    FLAKE = "/home/wasd/linix";
    SSH_AUTH_SOCK = "/run/user/\${UID}/keyring/ssh";

    EDITOR = "nvim";
    VISUAL = "nvim";
    SUDO_EDITOR = "nvim";
    SYSTEMD_PAGERSECURE = "true";
    PAGER = "less -FR";
    MANPAGER = "nvim +Man!";
  };
}
