----------------------
------ MONITORS ------
----------------------

-- See https://wiki.hyprland.org/Configuring/Monitors/

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
  sclae = "1",
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
  position = "0x-1080",
  scale = "1",
})
---- Monitor at HM
hl.monitor({
  output = "desc:LG Electronics 25BL55WY 103NTYT24818",
  mode = "preferred",
  position = "0x-1200",
  scale = "1",
})

-- Home monitors
---- Main home desktop monitor
hl.monitor({ output = "desc:LG Electronics E2411 401NDMT3N491", mode = "preferred", position = "auto", scale = "1" })
hl.workspace({ workspace = "1", monitor = "desc:LG Electronics E2411 401NDMT3N491", default = "true'" })
hl.workspace({ workspace = "2", monitor = "desc:LG Electronics E2411 401NDMT3N491" })
hl.workspace({ workspace = "3", monitor = "desc:LG Electronics E2411 401NDMT3N491" })
hl.workspace({ workspace = "4", monitor = "desc:LG Electronics E2411 401NDMT3N491" })
hl.workspace({ workspace = "5", monitor = "desc:LG Electronics E2411 401NDMT3N491" })
---- second home desktop monitor
hl.monitor({ output = "desc:Samsung Electric Company T24B350", mode = "preffered", position = "auto", scale = "1" })
hl.workspace({ workspace = "6", monitor = "desc:Samsung Electric Company T24B350" })
hl.workspace({ workspace = "7", monitor = "desc:Samsung Electric Company T24B350" })
hl.workspace({ workspace = "8", monitor = "desc:Samsung Electric Company T24B350" })
hl.workspace({ workspace = "9", monitor = "desc:Samsung Electric Company T24B350" })
hl.workspace({ workspace = "10", monitor = "desc:Samsung Electric Company T24B350", default = "true" })

-- office monitors
---- new Dell monitor
-- monitor = desc:Dell Inc. DELL P2723QE 8TCR964, preferred, 0x-2160, 2
hl.monitor({ output = "desc:Dell Inc. DELL P2723QE 8TCR964", mode = "preferred", position = "0x-1080", scale = "2" })
---- old Samsung in office
hl.monitor({
  output = "desc:Samsung Electric Company S27B970 0x5A565137",
  mode = "preferred",
  position = "0x-1080",
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

-------------------------
------ Windowrules ------
-------------------------

hl.windowrule({ match = { class = ".*" }, idle_inhibit = "fullscreen" })
hl.windowrule({ match = { class = "^(xwaylandvideobridge)$" }, opacity = "0.0 override" })
hl.windowrule({ match = { class = "^(xwaylandvideobridge)$" }, no_anim = true })
hl.windowrule({ match = { class = "^(xwaylandvideobridge)$" }, no_initial_focus = true })
hl.windowrule({ match = { class = "^(xwaylandvideobridge)$" }, max_size = { 1, 1 } })
hl.windowrule({ match = { class = "^(xwaylandvideobridge)$" }, no_blur = true })
hl.windowrule({ match = { class = "^(xwaylandvideobridge)$" }, no_focus = true })
-- Ignore maximize requests from apps. You'll probably like this.
hl.windowrule({ match = { class = ".*" }, suppress_event = "maximize" })
-- Fix some dragging issues with XWayland
hl.windowrule({
  match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
  no_focus = true,
})

-------------------
------ theme ------
-------------------

local source = "~/.config/hypr/mocha.conf"
hl.on("hyprland.start", function()
  hl.exec_cmd("hyprctl setcursor catppuccin-mocha-dark-cursors 28")
end)

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
hl.on("hyprland-start", function()
  hl.exec_cmd("waybar & hyprpaper & hypridle")
  hl.exec_cmd("[workspace 1 silent] " .. terminal)
  hl.exec_cmd(terminal .. " -e ${HOME}/.config/hypr/set_laptop_keyboard_enabled.fish")
  hl.exec_cmd("nextcloud --background")
  hl.exec_cmd(
    ' [workspace special:notes silent] $terminal --background-opacity=0.95 -e nvim -c "cd ~/Nextcloud/notes/" ~/Nextcloud/notes/'
  )
  hl.exec_cmd(
    ' [workspace special:todos silent] $terminal -e nvim -c "cd ~/Nextcloud/notes/" ~/Nextcloud/notes/Todos.md'
  )
  hl.exec_cmd("ibus start --type wayland")
  hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
end)

-----------------------------------
------ ENVIRONMENT VARIABLES ------
-----------------------------------

hl.env("XCURSOR_SIZE", "14")
hl.env("XCURSOR_SIZE", "14")
