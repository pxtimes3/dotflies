local wezterm = require 'wezterm'

return {
	color_scheme = "tokyonight",
	default_prog = { "fish" },
	font = wezterm.font("JetBrains Mono Nerd Font"),
	font_size = 10.0,
	line_height = 1.1,
	
	-- requires:
	-- set tempfile (mktemp) \
  	-- 	&& curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo \
  	-- 	&& tic -x -o ~/.terminfo $tempfile \
  	-- 	&& rm $tempfile
	term = "wezterm",

	-- disable tabs + tabkey 
	enable_tab_bar = false,
	keys = {
		{
			key = "t",
			mods = "SUPER",
			action = wezterm.action.DisableDefaultAssignment,
		},
	},
}
