_: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require "wezterm"
      local act = wezterm.action
      return {
        check_for_updates = false,
        default_prog = { 'zsh' },
        font_size = 16,
        font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Regular', italic = true }),
        adjust_window_size_when_changing_font_size = false,
        default_cursor_style = "SteadyBlock",
        cursor_blink_ease_in = 'EaseIn',
        cursor_blink_ease_out = 'EaseOut',
        color_scheme = 'Oxocarbon Dark',
        enable_scroll_bar = false,
        enable_tab_bar = false,
        enable_wayland = false,
        front_end = "WebGpu",
        use_fancy_tab_bar = false,
        window_decorations = "RESIZE",
        hide_tab_bar_if_only_one_tab = true,
        scrollback_lines = 8000,
      }
    '';
  };
  xdg.configFile."wezterm/colors/.oxocarbon-dark.toml".text = ''
    [colors]
    background = '#161616'
    foreground = '#ffffff'
    cursor_bg = '#ffffff'
    cursor_border = '#ffffff'
    cursor_fg = '#161616'

    ansi = [
        '#262626',
        '#ee5396',
        '#42be65',
        '#ffe97b',
        '#33b1ff',
        '#ff7eb6',
        '#3ddbd9',
        '#dde1e6',
    ]
    brights = [
        '#393939',
        '#ee5396',
        '#42be65',
        '#ffe97b',
        '#33b1ff',
        '#ff7eb6',
        '#3ddbd9',
        '#ffffff',
    ]

    [colors.tab_bar]
    background = "#262626"

    [colors.tab_bar.active_tab]
    bg_color = '#161616'
    fg_color = '#ffffff'
    intensity = 'Normal'
    italic = false
    strikethrough = false
    underline = 'None'

    [colors.tab_bar.inactive_tab]
    bg_color = '#262626'
    fg_color = '#ffffff'
    intensity = 'Normal'
    italic = false
    strikethrough = false
    underline = 'None'

    [colors.tab_bar.new_tab]
    bg_color = '#262626'
    fg_color = '#ffffff'
    intensity = 'Normal'
    italic = false
    strikethrough = false
    underline = 'None'


    [metadata]
    name = 'Oxocarbon Dark'
    origin_url = 'https://github.com/nyoom-engineering/oxocarbon'
  '';
}
