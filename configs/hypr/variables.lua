-- variables.lua
-- App variables and environment setup
-- Replaces variables.conf

terminal    = "kitty"
fileManager = "thunar"
menu        = "noctalia msg panel-toggle launcher"
browser     = "firefox"

hl.env("XCURSOR_SIZE",   "24")
hl.env("XCURSOR_THEME",  "BreezeX-RosePine")

hl.env("XDG_CURRENT_DESKTOP",  "Hyprland")
hl.env("XDG_SESSION_TYPE",     "wayland")
hl.env("XDG_SESSION_DESKTOP",  "Hyprland")

hl.env("QT_QPA_PLATFORM",                   "wayland")        -- If you use Qt apps
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")            -- If you use Qt apps
hl.env("MOZ_ENABLE_WAYLAND",                 "1")             -- If you use Firefox/Mozilla
