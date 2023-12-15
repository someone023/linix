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
    ./anyrun.nix
    ./hyprland
    #./hyprpaper.nix
    #./swayidle.nix
    #./swaylock.nix
  ];

  home.packages = with pkgs; [
    # utils
    wl-clipboard
    wl-screenrec
    wlogout
    wlr-randr
    polkit-kde-agent
    xdg-desktop-portal-hyprland


    #themes
    juno-theme
    bibata-cursors
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  # fake a tray to let apps start
  # https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };
}
