local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on('mux-startup', function()
  local tab, pane, window = mux.spawn_window {}
  pane:split { direction = 'Right' }
end)


return {
	color_scheme = "tokyonight",
	default_prog = { "fish" },
	font = wezterm.font("JetBrains Mono Nerd Font"),
	font_size = 10.0,
	line_height = 1.1,
	
	term = "xterm-256color",

	enable_tab_bar = true,

  -- multipass!?
  unix_domains = {
    {
    -- The name; must be unique amongst all domains
    name = 'pxbeard-main',

      -- The path to the socket.  If unspecified, a resonable default
      -- value will be computed.

      -- socket_path = "/some/path",

      -- If true, do not attempt to start this server if we try and fail to
      -- connect to it.

      -- no_serve_automatically = false,

      -- If true, bypass checking for secure ownership of the
      -- socket_path.  This is not recommended on a multi-user
      -- system, but is useful for example when running the
      -- server inside a WSL container but with the socket
      -- on the host NTFS volume.

      -- skip_permissions_check = false,
    },
  },
  default_gui_startup_args =  { 'connect', 'pxbeard-main' }
}
