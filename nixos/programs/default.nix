{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./qt.nix
    ./xdg.nix
    ./git.nix
  ];

  programs = {
    # make HM-managed GTK stuff work
    dconf.enable = true;

    kdeconnect.enable = true;

    seahorse.enable = true;
  };
}
