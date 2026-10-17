-- autostart.lua
-- Programs to launch on startup
-- Replaces autostart.conf

hl.on("hyprland.start", function()
    hl.exec_cmd("hypridle")                         -- Starts the idle daemon
    hl.exec_cmd("udiskie")                          -- Starts USB drive daemon
    hl.exec_cmd("hyprpaper")                        -- Used for wallpaper
    hl.exec_cmd("emacs --daemon")                   -- Emacs is always open
    hl.exec_cmd("noctalia")
    hl.exec_cmd("hyprctl setcursor BreezeX-RosePine-Linux 24")  -- Sets cursor to rose pine
end)
