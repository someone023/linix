{pkgs, ...}: {
  users.users = {
    wasd = {
      isNormalUser = true;
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINhqO14oVhYp3iAYnKH1h43czDOxy6C/zU0FRvTQ2MP9 ali"
      ];
      extraGroups = ["input" "libvirtd" "networkmanager" "plugdev" "transmission" "video" "wheel"];
    };
  };
}
