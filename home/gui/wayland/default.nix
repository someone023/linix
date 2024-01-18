{
  pkgs,
  lib,
  self,
  inputs,
  config,
  ...
}:
# Wayland config
{
  imports = [
    ./anyrun
    ./hyprland
    ./mako.nix
    ./environment.nix
    #./hyprpaper.nix
    #./swayidle.nix
    #./swaylock.nix
  ];

  home.packages = with pkgs; [
    # utils
    wl-clipboard
    wl-clip-persist
    wlogout
    wlr-randr
    xdg-desktop-portal-hyprland

    # misc
    libnotify

    cliphist

    #themes
    bibata-cursors
  ];

  # fake a tray to let apps start
  # https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };
}
