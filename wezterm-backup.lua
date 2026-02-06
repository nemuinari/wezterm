local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ===== Colors =====
config.color_scheme = "Catppuccin Mocha"

-- ===== Font =====
config.font = wezterm.font_with_fallback({
	"Hack Nerd Font",
	"MS Gothic",
})
config.font_size = 11

-- ===== Window =====
config.window_decorations = "RESIZE"
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true

-- ===== Initial Size =====
config.initial_cols = 200
config.initial_rows = 50

-- ===== Padding =====
config.window_padding = {
	left = 12,
	right = 12,
	top = 8,
	bottom = 8,
}

-- ===== Shell =====
config.default_prog = { "pwsh", "-NoLogo" }

-- ===== Scrollback =====
config.scrollback_lines = 3500

-- ===== Keys =====
local act = wezterm.action

config.keys = {
	-- Alt + Arrow keys for pane navigation
	{ key = "LeftArrow", mods = "ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "ALT", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "ALT", action = act.ActivatePaneDirection("Down") },

	-- Ctrl + Shift + Arrow for pane split
	{ key = "Enter", mods = "ALT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "n", mods = "ALT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- Tab navigation
	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },

	-- Tab creation
	{ key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "ALT", action = act.CloseCurrentTab({ confirm = true }) },

	-- Copy mode
	{ key = "c", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },
}

-- ===== Mouse =====
config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act.PasteFrom("Clipboard"),
	},
}

config.allow_win32_input_mode = true
config.win32_system_backdrop = "Acrylic"

return config
