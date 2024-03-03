{
  pkgs,
  lib,
  ...
}: {
  programs = {
    fuse.userAllowOther = true;
    zsh.enable = true;
    dconf.enable = true;
  };

  users = {
    mutableUsers = false;
    users = {
      wasd = {
        isNormalUser = true;
        hashedPasswordFile = "/persist/secrets/wasd";
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBM0GCFnOpqMwYc9HN288uyCkl1qqUs193JqwEV3MJth someone023"
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
