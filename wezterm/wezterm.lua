local wezterm = require 'wezterm'

return {
  initial_rows = 25,
  initial_cols = 80,
  font = wezterm.font 'Fira Code',
  font_size = 14,
  enable_tab_bar = false,
  default_prog = { '/usr/bin/tmux', '-2' },
  ratelimit_output_bytes_per_second = 4289999998,
  window_padding = {
    top = '0.3cell',
    left = '0.3cell',
    right = 0,
    bottom = 0,
  },
  disable_default_key_bindings = true,
  keys = {
    { key = 'Backspace', mods= 'CTRL', action = wezterm.action.SendString '\x08'},
  },
  --  color_scheme = "Tango (base16)",
}
