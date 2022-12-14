local wezterm = require 'wezterm'
local act = wezterm.action

return {
  adjust_window_size_when_changing_font_size = false,
  automatically_reload_config = true,
  initial_rows = 25,
  initial_cols = 80,
  font = wezterm.font 'Fira Code',
  font_size = 14,
  enable_tab_bar = false,
  selection_word_boundary = " \t\n{}[]()\"'`,;:│=&!%",
  default_prog = { '/usr/bin/tmux' },
  --default_prog = { "/usr/bin/bash", "-c", "exec /usr/bin/tmux" },
  -- color_scheme = "Tango (base16)",
  window_padding = {
    top = '0.3cell',
    left = '0.3cell',
    right = 0,
    bottom = 0,
  },
  audible_bell = "Disabled",
  visual_bell = {
    fade_in_duration_ms = 120,
    fade_out_duration_ms = 120,
  },
  disable_default_key_bindings = true,
  key_tables = {
    copy_mode = {},
    search_mode = {},
  },
  keys = {
    -- CTRL-backspace sends C-h
    { key = 'Backspace', mods= 'CTRL', action = act.SendString '\x08' },
    -- Change font size
    { key = '-', mods= 'CTRL', action = act.DecreaseFontSize },
    { key = '=', mods= 'CTRL', action = act.IncreaseFontSize },
    { key = '0', mods= 'CTRL', action = act.ResetFontSize },
    -- Copy & paste
    { key = 'Insert', mods= 'CTRL', action = act.CopyTo 'PrimarySelection' },
    { key = 'Insert', mods= 'SHIFT', action = act.PasteFrom 'PrimarySelection' },
    -- CTRL-c either copy or interrupts depending on selection
    {
        key = 'c',
        mods = 'CTRL',
        action = wezterm.action_callback(function(window, pane)
          local has_selection = window:get_selection_text_for_pane(pane) ~= ''
          if has_selection then
            window:perform_action(
              act.CopyTo 'Clipboard',
              pane
            )
            window:perform_action(act.ClearSelection, pane)
          else
            window:perform_action(
              act.SendKey { key = 'c', mods = 'CTRL' },
              pane
            )
          end
        end),
    },
    -- CTRL-v paste
    { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
  },
  disable_default_mouse_bindings = true,
  mouse_bindings = {
    -- Copy & paste
    { event = { Down = { streak = 1, button = 'Middle' } }, mods = 'NONE', action = act.PasteFrom 'PrimarySelection' },
    { event = { Down = { streak = 1, button = 'Left' } }, mods = 'NONE', action = act.SelectTextAtMouseCursor 'Cell' },
    { event = { Down = { streak = 2, button = 'Left' } }, mods = 'NONE', action = act.SelectTextAtMouseCursor 'Word' },
    { event = { Down = { streak = 3, button = 'Left' } }, mods = 'NONE', action = act.SelectTextAtMouseCursor 'Line' },
    { event = { Drag = { streak = 1, button = 'Left' } }, mods = 'NONE', action = act.ExtendSelectionToMouseCursor 'Cell' },
    { event = { Drag = { streak = 2, button = 'Left' } }, mods = 'NONE', action = act.ExtendSelectionToMouseCursor 'Word' },
    { event = { Drag = { streak = 3, button = 'Left' } }, mods = 'NONE', action = act.ExtendSelectionToMouseCursor 'Line' },
    { event = { Up = { streak = 1, button = 'Left' } }, mods = 'NONE', action = act.CompleteSelection 'PrimarySelection' },
    { event = { Up = { streak = 2, button = 'Left' } }, mods = 'NONE', action = act.CompleteSelection 'PrimarySelection' },
    { event = { Up = { streak = 3, button = 'Left' } }, mods = 'NONE', action = act.CompleteSelection 'PrimarySelection' },
    -- CTRL-click to open link
    { event = { Up = { streak = 1, button = 'Left' } }, mods = 'CTRL', action = act.OpenLinkAtMouseCursor },
    -- CTRL-scroll up/down to change the font size
    { event = { Down = { streak = 1, button = { WheelUp = 1 } } }, mods = 'CTRL', action = act.IncreaseFontSize },
    { event = { Down = { streak = 1, button = { WheelDown = 1 } } }, mods = 'CTRL', action = act.DecreaseFontSize },
  },
}
