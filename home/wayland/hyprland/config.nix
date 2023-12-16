{ config, ... }:
let
  pointer = "Bibata-Modern-Classic";
in
{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
    ];

    exec-once = [
      # set cursor for HL itself
      "hyprctl setcursor pointer 16"
      "systemctl --user start clight"
    ];

    general = {
      gaps_in = 2;
      gaps_out = 2;
      border_size = 1;
      "col.active_border" = "rgba(88888888)";
      "col.inactive_border" = "rgba(00000088)";

      allow_tearing = true;
    };

    decoration = {
      rounding = 16;
      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 0.02;

        passes = 3;
        size = 10;
      };

      drop_shadow = true;
      shadow_ignore_window = true;
      shadow_offset = "0 2";
      shadow_range = 20;
      shadow_render_power = 3;
      "col.shadow" = "rgba(00000055)";
    };

    animations = {
      enabled = true;
      animation = [
        "border, 1, 2, default"
        "fade, 1, 4, default"
        "windows, 1, 3, default, popin 80%"
        "workspaces, 1, 2, default, slide"
      ];
    };

    group {
    col.border_active = rgba (ca9ee6ff) rgba (f2d5cfff) 45 deg
      col.border_inactive = rgba(b4befecc) rgba(6c7086cc) 45deg
    col.border_locked_active = rgba(ca9ee6ff) rgba(f2d5cfff) 45deg
    col.border_locked_inactive = rgba(b4befecc) rgba(6c7086cc) 45deg
    }

    input = {
    kb_layout = "de";
    kb_variant = "us";

    # focus change on cursor move
    follow_mouse = 1;
    accel_profile = "flat";
    touchpad.scroll_factor = 0.1;
  };

  dwindle = {
    # keep floating dimentions while tiling
    no_gaps_when_only = 1;
    pseudotile = true;
    preserve_split = true;
  };

  misc = {
    # disable auto polling for config file changes
    disable_autoreload = true;

    force_default_wallpaper = 1;

    # disable dragging animation
    animate_mouse_windowdragging = false;

    # enable variable refresh rate (effective depending on hardware)
    vrr = 1;
  };

  # touchpad gestures
  gestures = {
    workspace_swipe = true;
    workspace_swipe_forever = true;
  };

  xwayland.force_zero_scaling = true;

  debug.disable_logs = false;
};
}
