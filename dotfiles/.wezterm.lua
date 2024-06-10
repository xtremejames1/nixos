-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

local mux = wezterm.mux
local act = wezterm.action
local keys = {
	{ key = "T", mods = "SHIFT|CTRL", action = wezterm.action.ShowLauncher },
}
local mouse_bindings = {}
local launch_menu = {}
local haswork, work = pcall(require, "work")

config.enable_wayland = false

--- Setup PowerShell options
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	--- Grab the ver info for later use.
	local success, stdout, stderr = wezterm.run_child_process({ "cmd.exe", "ver" })
	local major, minor, build, rev = stdout:match("Version ([0-9]+)%.([0-9]+)%.([0-9]+)%.([0-9]+)")
	local is_windows_11 = tonumber(build) >= 22000

	--- Make it look cool.
	if is_windows_11 then
		wezterm.log_info("We're running Windows 11!")
	end

	---config.default_domain = 'WSL:Ubuntu'
	--- Set Pwsh as the default on Windows
	config.default_prog = { "pwsh.exe", "-NoLogo" }
	table.insert(launch_menu, {
		label = "WSL",
		args = { "wsl.exe" },
	})
	table.insert(launch_menu, {
		label = "ssh home",
		args = { "ssh", "xtremejames1@main.xtremelab1.tech", "-p 322" },
	})
	table.insert(launch_menu, {
		label = "Pwsh",
		args = { "pwsh.exe", "-NoLogo" },
	})
else
	--- Non-Windows Machine
	table.insert(launch_menu, {
		label = "zsh",
		args = { "zsh", "-l" },
	})
	table.insert(launch_menu, {
		label = "bash",
		args = { "bash", "-l" },
	})
end

-- drip
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("IosevkaTerm Nerd Font Mono", { weight = "Medium", italic = false })
config.font_size = 10
config.default_cursor_style = "BlinkingBar"
config.launch_menu = launch_menu
config.keys = keys
-- and finally, return the configuration to wezterm
return config
