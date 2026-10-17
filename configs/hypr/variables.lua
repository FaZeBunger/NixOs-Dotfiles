-- variables.lua
-- App variables and environment setup
-- Replaces variables.conf
--


-- I don't really have a dedicated file for this stuff so this is where its going for now.
--
-- Force Hyprland to pass mouse and focus events to Noctalia inside the super window
hl.layer_rule({
    name = "noctalia",
    match = {
        -- Targets the bar, panels, notification layer, and dock namespaces
        namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
    },
    no_anim = true,       -- Prevents animations from messing with pointer focus
    ignore_alpha = 0.5,   -- Keeps transparent sections clickable
    blur = true,          -- Ensures blur applies correctly to the bar panels
    blur_popups = true,   -- Passes layer depth downstream to context menus
})


terminal    = "kitty"
fileManager = "thunar"
menu        = "noctalia msg panel-toggle launcher"
browser     = "firefox"

hl.env("XCURSOR_SIZE",      "24")
hl.env("XCURSOR_THEME",     "BreezeX-RosePine-Linux")
hl.env("HYPRCURSOR_SIZE",   "24")
hl.env("HYPRCURSOR_THEME",  "BreezeX-RosePine-Linux")

hl.env("XDG_CURRENT_DESKTOP",  "Hyprland")
hl.env("XDG_SESSION_TYPE",     "wayland")
hl.env("XDG_SESSION_DESKTOP",  "Hyprland")

hl.env("QT_QPA_PLATFORM",                   "wayland")        -- If you use Qt apps
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")            -- If you use Qt apps
hl.env("MOZ_ENABLE_WAYLAND",                 "1")             -- If you use Firefox/Mozilla
