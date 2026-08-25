-- binds.lua
-- Keybindings
-- Replaces binds.conf
-- https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod = "SUPER"

-- Apps
hl.bind(mainMod .. " + Return",       hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",            hl.dsp.window.kill())
hl.bind(mainMod .. " + C",            hl.dsp.exec_cmd("grimblast --freeze copy area"))
hl.bind(mainMod .. " + E",            hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",            hl.dsp.window.float({action = "toggle"}))
hl.bind("ALT + space",                hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + R",            hl.dsp.exec_cmd("rofi -show run"))
hl.bind(mainMod .. " + B",            hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + F",    hl.dsp.window.fullscreen())

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",         hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right",        hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",           hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",         hl.dsp.focus({ direction = "down" }))

-- Resize windows with mainMod + SHIFT + arrow keys (repeating)
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({  x = 10,   y = 0 }), { ["repeat"] = true })
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -10,   y = 0 }), { ["repeat"] = true })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({   x = 0, y = -10 }), { ["repeat"] = true })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({   x = 0,  y = 10 }), { ["repeat"] = true })

-- Switch workspaces with mainMod + [0-9]
for i = 1, 9 do
  hl.bind(mainMod .. " + " .. i,              hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. i,      hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + 0",              hl.dsp.focus({ workspace = 0 }))
hl.bind(mainMod .. " + SHIFT + 0",      hl.dsp.window.move({ workspace = 0 }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",            hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S",    hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down",   hl.dsp.focus({ workspace = "m+1"}))
hl.bind(mainMod .. " + mouse_up",     hl.dsp.focus({ workspace = "m-1"}))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272",    hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",    hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume
hl.bind("XF86AudioRaiseVolume",        hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),   { ["repeat"] = true })
hl.bind("XF86AudioLowerVolume",        hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),  { ["repeat"] = true })
hl.bind("XF86AudioMute",               hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute",            hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

-- LCD brightness
hl.bind("XF86MonBrightnessUp",         hl.dsp.exec_cmd("brightnessctl s 10%+"), { ["repeat"] = true })
hl.bind("XF86MonBrightnessDown",       hl.dsp.exec_cmd("brightnessctl s 10%-"), { ["repeat"] = true })

-- Media keys (requires playerctl)
hl.bind("XF86AudioNext",              hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause",             hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",              hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",              hl.dsp.exec_cmd("playerctl previous"),     { locked = true })
