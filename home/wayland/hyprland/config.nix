{ config, ... }:
let
  pointer = "Bibata-Modern-Classic";
in
{
  wayland.windowManager.hyprland.settings =
    {

      monitor = [
        "eDP-1, 1920x1080, 0x0, 1"
        "HDMI-A-1, 1920x1080, 1920x0, 1"
      ];


      "$mod" = "SUPER";
      env = [
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "XDG_SESSION_DESKTOP=Hyprland"
        "MOZ_DISABLE_RDD_SANDBOX,1"
        "EGL_PLATFORM,wayland"
        "MOZ_ENABLE_WAYLAND,1"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];

      exec-once = [
        # set cursor for HL itself
        "hyprctl setcursor pointer 16"
        "systemctl --user start clight"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland"
      ];

      general = {
        gaps_in = 4;
        gaps_out = 4;
        border_size = 1;
        "col.active_border" = "0xffb4befe 0xff89dceb 45deg";
        "col.inactive_border" = "0xff313244 0xff45475a 45deg";
        resize_on_border = true;
        "layout" = "dwindle";
        no_border_on_floating = false;
        no_cursor_warps = false;
      };

      decoration = {
        rounding = 16;
        blur = {
          enabled = true;
          brightness = 1.0;
          contrast = 1.0;
          noise = 0.02;

          passes = 4;
          size = 10;
        };

        drop_shadow = true;
        shadow_ignore_window = true;
        shadow_offset = "0 2";
        shadow_range = 8;
        shadow_render_power = 3;
        "col.shadow" = "0xffb4befe";
        "col.shadow_inactive" = "0x50000000";
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

      group = {
        groupbar = {
          font_size = 16;
          gradients = false;
        };

        #"col.border_active" = "rgba (ca9ee6ff) rgba (f2d5cfff) 45 deg";
        #"col.border_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
      };


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
