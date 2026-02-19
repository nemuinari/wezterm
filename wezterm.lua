-- =======================================
-- WezTerm Configuration File
-- =======================================
local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- ========================================
-- System & Performance
-- ========================================
config.automatically_reload_config = false
config.check_for_updates = false
config.front_end = "OpenGL" -- "WebGpu" | "OpenGL" | "Software"
config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe", "-NoLogo" }
config.scrollback_lines = 5000

-- ========================================
-- Appearance (Kanagawa)
-- ========================================
config.color_scheme = "Kanagawa (Gogh)"
config.colors = {
	background = "#0c0c0c",
	tab_bar = { background = "#0c0c0c" },
}

config.window_background_opacity = 0.95
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

-- Font Settings
config.font = wezterm.font_with_fallback({
	{ family = "FiraCode Nerd Font Mono", weight = "Regular" },
})
config.font_size = 20

-- ========================================
-- Tab Bar Customization
-- ========================================
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_frame = {
	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local active_bg = "#2a2a37"
	local inactive_bg = "#1f1f28"
	local active_fg = "#dcd7ba"
	local inactive_fg = "#727169"
	local background = tab.is_active and active_bg or inactive_bg
	local foreground = tab.is_active and active_fg or inactive_fg
	local title = " " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. " "

	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
	}
end)

-- ========================================
-- Keybindings
-- ========================================
config.keys = {
	{ key = "Enter", mods = "ALT", action = act.SplitPane({ direction = "Down", size = { Percent = 35 } }) },
	{ key = "s", mods = "ALT", action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }) },
	{ key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "w", mods = "CTRL", action = act.ActivateKeyTable({ name = "pane_nav", one_shot = true }) },
	{ key = "Space", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },
	{ key = "h", mods = "ALT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "j", mods = "ALT", action = act.AdjustPaneSize({ "Down", 2 }) },
	{ key = "k", mods = "ALT", action = act.AdjustPaneSize({ "Up", 2 }) },
	{ key = "l", mods = "ALT", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "UpArrow", mods = "SHIFT", action = act.ScrollByLine(-1) },
	{ key = "DownArrow", mods = "SHIFT", action = act.ScrollByLine(1) },
	{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
	{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
}

-- ========================================
-- Key Tables
-- ========================================
config.key_tables = {
	pane_nav = {
		{ key = "h", action = act.ActivatePaneDirection("Left") },
		{ key = "j", action = act.ActivatePaneDirection("Down") },
		{ key = "k", action = act.ActivatePaneDirection("Up") },
		{ key = "l", action = act.ActivatePaneDirection("Right") },
		{ key = "Escape", action = "PopKeyTable" },
	},
	copy_mode = {
		{ key = "h", action = act.CopyMode("MoveLeft") },
		{ key = "j", action = act.CopyMode("MoveDown") },
		{ key = "k", action = act.CopyMode("MoveUp") },
		{ key = "l", action = act.CopyMode("MoveRight") },
		{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{
			key = "y",
			mods = "NONE",
			action = act.Multiple({
				{ CopyTo = "ClipboardAndPrimarySelection" },
				{ CopyMode = "Close" },
			}),
		},
		{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
		{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
	},
}

-- ========================================
-- Mouse Bindings
-- ========================================
config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act.PasteFrom("Clipboard"),
	},
}

return config
