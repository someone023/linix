{config, ...}: let
  inherit (config.programs.matugen) variant;
in {
  wayland.windowManager.hyprland.settings = {
    # layer rules
    layerrule = let
      layers = "^(eww-.+|bar|system-menu|anyrun|gtk-layer-shell|osd[0-9])$";
    in [
      "blur, ${layers}"
      "xray 1, ^(bar|gtk-layer-shell)$"
      "ignorealpha 0.2, ${layers}"
      "ignorealpha 0${
        if variant == "dark"
        then ".5"
        else ""
      },    ];

    # window rules
    windowrulev2 = [
       # make Firefox PiP window floating and sticky
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      # throw sharing indicators away
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"

      # start spotify in ws9
      "workspace 9 silent, class:^(spotify)$"


      # fix xwayland apps
      "rounding 0, xwayland:1"
      "center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$"
      "size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$"
    ];
  };
}
