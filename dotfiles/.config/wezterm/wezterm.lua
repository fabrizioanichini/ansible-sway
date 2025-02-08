-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- For example, changing the color scheme:
config.color_scheme = 'Dracula'

config.font = wezterm.font('JetBrains Mono')

config.font_size = 10 

config.enable_tab_bar = false

-- and finally, return the configuration to wezterm
return config
