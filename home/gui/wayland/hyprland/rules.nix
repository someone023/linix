{config, ...}: {
  wayland.windowManager.hyprland.settings = {
    # layer rules
    layerrule = let
      layers = "^(eww-.+|notifications|system-menu|anyrun|kitty|gtk-layer-shell|osd[0-9])$";
    in [
      "blur, ${layers}"
      "xray 1, ^(bar|gtk-layer-shell)$"
      "ignorealpha 0.2, ${layers}"
      "ignorealpha 0.5, ^(system-menu|anyrun)$"
    ];

    # window rules
    windowrulev2 = [
      "noanim, class:neovide"
      "idleinhibit focus,class:kitty"
      "idleinhibit fullscreen, class:^(firefox)$"

      "float,class:udiskie"

      "float,class:pavucontrol"
      "float,title:^(Volume Control)$"
      "size 800 600,title:^(Volume Control)$"
      "move 75 44%,title:^(Volume Control)$"
      "float, class:^(imv)$"

      # throw sharing indicators away
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"

      "workspace 4, title:^(.*(Disc|WebC)ord.*)$"
      "workspace 2, class:^(firefox)$"
      "workspace 4 , title:^(.*Firefox.*)$"
      "workspace 5, title:^(.*(Disc|WebC)ord.*)$"

      # fix xwayland apps
      "rounding 0, xwayland:1"
      "center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$"
      "size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$"
    ];
    workspace = [
      "1, monitor:eDP-1, default:true"
      "2, monitor:eDP-1, default:true"
      "3, monitor:eDP-1, default:true"
      "4, monitor:HDMI-A-1, default:true"
      "5, monitor:HDMI-A-1, default:true"
    ];
  };
}
