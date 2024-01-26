{pkgs, ...}:
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
    wl-clipboard
    wl-clip-persist
    wlogout
    wlr-randr
    libnotify
    cliphist
  ];

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
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
