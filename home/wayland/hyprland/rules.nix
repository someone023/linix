{ config, ... }:
let
  inherit (config.programs.matugen) variant;
in
{
  wayland.windowManager.hyprland.settings = {
    # layer rules
    layerrule =
      let
        layers = "^(eww-.+|bar|system-menu|anyrun|gtk-layer-shell|osd[0-9])$";
      in
      [
        "blur, ${layers}"
        "xray 1, ^(bar|gtk-layer-shell)$"
        "ignorealpha 0.2, ${layers}"
        "ignorealpha 0.5, ^(system-menu|anyrun)$"
      ];

    # window rules
    windowrulev2 = [
      # telegram media viewer
      "float, title:^(Media viewer)$"


      # make Firefox PiP window floating and sticky
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      # idle inhibit while watching videos
      "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
      "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
      "idleinhibit fullscreen, class:^(firefox)$"
      "workspace 4 , title:^(.*Firefox.*)$"
      "workspace 5, title:^(.*(Disc|WebC)ord.*)$"

      "dimaround, class:^(gcr-prompter)$"

      # fix xwayland apps
      "rounding 0, xwayland:1"
      "center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$"
      "size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$"
    ];
  };
}
