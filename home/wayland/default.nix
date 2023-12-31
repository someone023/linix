{ pkgs
, lib
, self
, inputs
, config
, ...
}:
# Wayland config
{
  imports = [
    ./anyrun.nix
    ./hyprland
    ./mako.nix
    #./hyprpaper.nix
    #./swayidle.nix
    #./swaylock.nix
  ];

  home.packages = with pkgs; [
    # utils
    wl-clipboard
    wlogout
    wlr-randr
    xdg-desktop-portal-hyprland

    cliphist


    #themes
    bibata-cursors
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # fake a tray to let apps start
  # https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
}
