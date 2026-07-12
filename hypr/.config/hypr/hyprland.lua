------ MONITORS ------
----------------------

-- See https://wiki.hyprland.org/Configuring/Monitors/

local hostname_handle = io.popen("hostnamectl hostname")
local hostname = ""
if hostname_handle then
	hostname = hostname_handle:read("*a"):gsub("%s+$", "")
	hostname_handle:close()
end
local is_laptop = hostname:sub(-3) == "-lt"

local homeMonitorPosition = is_laptop and "auto-up" or "auto-left"

-- default
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

-- Laptop displays
---- Thinkpad laptop display
hl.monitor({
	output = "desc:China Star Optoelectronics Technology Co. Ltd MNE007JA1-3",
	mode = "preferred",
	position = "0x0",
	scale = "1",
})
---- Dell laptop display
hl.monitor({
	output = "desc:AU Optronics 0x1036",
	mode = "preferred",
	position = "0x0",
	scale = "1",
})

-- Monitors used with Laptop
---- Monitor used at K
hl.monitor({
	output = "desc:Philips Consumer Electronics Company PHL 274E5 UHB1413032391",
	mode = "preferred",
	position = "auto-up",
	scale = "1",
})
---- Monitor at HM
hl.monitor({
	output = "desc:LG Electronics 25BL55WY 103NTYT24818",
	mode = "preferred",
	position = "auto-up",
	scale = "1",
})

-- Home monitors
---- Main home desktop monitor
hl.monitor({
	output = "desc:LG Electronics E2411 401NDMT3N491",
	mode = "preferred",
	position = homeMonitorPosition,
	scale = "1",
})

hl.monitor({
	output = "desc:Samsung Electric Company T24B350",
	mode = "preferred",
	scale = "1",
})

-- office monitors
---- new office monitor
hl.monitor({
	output = "desc:Dell Inc. DELL U3223QZ 421B8H3",
	mode = "preferred",
	position = "auto-up",
	scale = "2",
})
---- new Dell monitor
-- monitor = desc:Dell Inc. DELL P2723QE 8TCR964, preferred, 0x-2160, 2
hl.monitor({ output = "desc:Dell Inc. DELL P2723QE 8TCR964", mode = "preferred", position = "auto-up", scale = "2" })
---- old Samsung in office
hl.monitor({
	output = "desc:Samsung Electric Company S27B970 0x5A565137",
	mode = "preferred",
	position = "auto-up",
	scale = "1",
})
---- lab screen
hl.monitor({
	output = "desc:Iiyama North America PL6542U 0x01010101",
	mode = "preferred",
	position = "auto",
	scale = "1",
	mirror = "desc:AU Optronics 0x1036",
})

------------------------
------ WORKSPACES ------
------------------------

-- Workspaces
if not is_laptop then
	hl.workspace_rule({ workspace = "1", monitor = "desc:LG Electronics E2411 401NDMT3N491", default = true })
	hl.workspace_rule({ workspace = "2", monitor = "desc:LG Electronics E2411 401NDMT3N491" })
	hl.workspace_rule({ workspace = "3", monitor = "desc:LG Electronics E2411 401NDMT3N491" })
	hl.workspace_rule({ workspace = "4", monitor = "desc:LG Electronics E2411 401NDMT3N491" })
	hl.workspace_rule({ workspace = "5", monitor = "desc:LG Electronics E2411 401NDMT3N491" })
	-- second home desktop monitor
	hl.workspace_rule({ workspace = "6", monitor = "desc:Samsung Electric Company T24B350" })
	hl.workspace_rule({ workspace = "7", monitor = "desc:Samsung Electric Company T24B350" })
	hl.workspace_rule({ workspace = "8", monitor = "desc:Samsung Electric Company T24B350" })
	hl.workspace_rule({ workspace = "9", monitor = "desc:Samsung Electric Company T24B350" })
	hl.workspace_rule({ workspace = "10", monitor = "desc:Samsung Electric Company T24B350", default = true })
end
-- special workspaces
hl.workspace_rule({ workspace = "special:notes" })
hl.workspace_rule({ workspace = "special:todos" })

-------------------------
------ Windowrules ------
-------------------------

hl.window_rule({ match = { class = ".*" }, idle_inhibit = "fullscreen" })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, opacity = "0.0 override" })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_anim = true })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_initial_focus = true })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, max_size = { 1, 1 } })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_blur = true })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_focus = true })
-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
-- Fix some dragging issues with XWayland
hl.window_rule({
	match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
	no_focus = true,
})
hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-------------------------
------ MY PROGRAMS ------
-------------------------

-- See https://wiki.hyprland.org/Configuring/Keywords/

-- Set programs that you use
local terminal = "ghostty"
local fileManager = "nautilus"
-- $fileManager = ghostty -e yazi
local menu = "wofi --show drun"

-----------------------
------ AUTOSTART ------
-----------------------
---
hl.on("hyprland.start", function()
	hl.exec_cmd("hyprctl setcursor catppuccin-mocha-dark-cursors 28")
	hl.exec_cmd("waybar & hyprpaper & hypridle")
	hl.exec_cmd(terminal, { workspace = "1 silent" })
	hl.exec_cmd(terminal .. " -e ${HOME}/.config/hypr/set_laptop_keyboard_enabled.fish")
	hl.exec_cmd("nextcloud --background")
	hl.exec_cmd(terminal .. ' --background-opacity=0.95 -e nvim -c "cd ~/Nextcloud/notes/" ~/Nextcloud/notes/', {
		workspace = "special:notes silent",
	})
	hl.env("TODO_DIR", os.getenv("HOME") .. "/Nextcloud/todos/")
	hl.exec_cmd(terminal .. " --background-opacity=0.95 -e $HOME/.cargo/bin/tuxedo", {
		workspace = "special:todos silent",
	})
	hl.exec_cmd("ibus start --type wayland")
	hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
end)

-----------------------------------
------ ENVIRONMENT VARIABLES ------
-----------------------------------

hl.env("XCURSOR_SIZE", "14")
hl.env("XCURSOR_SIZE", "14")

local mainMod = "SUPER"

hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprlock"))
-- hl.bind(
--   mainMod .. " + M",
--   hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
-- )
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit")) -- dwindle only

-- hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ workspace = "e-1" }))
-- hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- screenshots
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + CTRL + O", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("hyprshot -m output"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + N", hl.dsp.workspace.toggle_special("notes"))
hl.bind(mainMod .. " + T", hl.dsp.workspace.toggle_special("todos"))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

---------------------------
------ LOOK AND FEEL ------
---------------------------

hl.config({
	general = {
		gaps_in = 1,
		gaps_out = 1,
		border_size = 2,
		col = {
			active_border = { colors = { "rgba(89dcebee)", angle = 45 } },
			inactive_border = "rgba(11111baa)",
		},
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 5,
		active_opacity = 1.0,
		-- inactive_opacity = 0.95,
		inactive_opacity = 1,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},
	animations = {
		enabled = false,
	},
	dwindle = {
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
	misc = {
		force_default_wallpaper = 1,
		disable_hyprland_logo = true,
	},
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "caps:swapescape,compose:ralt",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = true,
		},
	},
	gestures = {},
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})
