{
  config = ''
    local wezterm = require("wezterm")
    local act = wezterm.action

    return {
        check_for_updates = false,
    	exit_behavior = "CloseOnCleanExit",

        enable_scroll_bar = true,

    	font_size = 15.0,
    	font = wezterm.font 'JetBrainsMono Nerd Font Mono'

    	audible_bell = "Disabled",
        enable_tab_bar = true,
    	hide_tab_bar_if_only_one_tab = true,
    	default_cursor_style = "SteadyUnderline",
    	window_background_opacity = 0.85,

    	window_padding = {
    		left = 16,
    		right = 16,
    		top = 16,
    		bottom = 16,
    	},
        config.color_scheme = 'Tokyo Night'

      },
  '';
}
