local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

config.mouse_bindings = {
  -- Scrolling up while holding CTRL increases the font size
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'CTRL',
    action = act.IncreaseFontSize,
  },

  -- Scrolling down while holding CTRL decreases the font size
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'CTRL',
    action = act.DecreaseFontSize,
  },
}

-- For example, changing the color scheme:
config.color_scheme = 'Dracula (Official)'

-- Additional configurations can be added here
config.font = wezterm.font('SauceCodePro NFM Medium')
config.window_background_opacity = 0.77
config.window_close_confirmation = 'NeverPrompt'
config.hide_tab_bar_if_only_one_tab = true
config.enable_wayland=true
config.adjust_window_size_when_changing_font_size = false
config.font_size = 14.0
config.initial_cols = 110    -- Set the number of columns
config.initial_rows = 30     -- Set the number of rows
config.window_decorations = "NONE"

return config
