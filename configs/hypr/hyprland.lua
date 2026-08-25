-- hyprland.lua
-- Main Hyprland configuration entry point
-- Replaces hyprland.conf
-- https://wiki.hypr.land/Configuring/Start/

require("variables")   -- App vars and environment
require("autostart")   -- exec-once programs
require("binds")       -- Keybindings
require("input")       -- Keyboard, mouse, touchpad, gestures


--------------------
---- MONITORS ----
--------------------

-- https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "DP-1",
    mode     = "1920x1080@165",
    position = "auto",
    scale    = 1,
})

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 8,

        border_size = 0,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before enabling
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 14,

        active_opacity   = 1.0,
        inactive_opacity = 0.95,

        blur = {
            enabled          = true,
            vibrancy         = 0.8,
            contrast         = 0.6,
            size             = 10,
            passes           = 2,
            ignore_opacity   = true,
            new_optimizations = true,
            xray             = true,
        },

        shadow = {
            enabled = false,
            sharp   = false,
        },
    },

    animations = {
        enabled = true,
    },

    -- Dwindle layout options
    -- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
    dwindle = {
        preserve_split = true,
    },

    -- Master layout options
    -- https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper  = 1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo    = true, -- Disables the random hyprland logo / anime girl background
        disable_splash_rendering = true,
    },
})

-- Animations
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.8 }, { 0.1, 1 } } })

hl.animation({ leaf = "windows",           speed = 5, enabled = true, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "windowsOut",        speed = 5, enabled = true, bezier = "myBezier", style = "slidefade 20%" })
hl.animation({ leaf = "workspaces",        speed = 5, enabled = true, bezier = "myBezier"})
hl.animation({ leaf = "specialWorkspace",  speed = 5, enabled = true, bezier = "myBezier", style = "slidefadevert" })

------------------------------
---- WINDOWS & WORKSPACES ----
------------------------------

-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Ignore maximize requests from apps
hl.window_rule({
    match = { class =".*" },
    suppress_event = "maximize"
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    match = {
      class = "^$",
      title = "^$",
      xwayland = "^$",
      float = true,
      fullscreen = false,
      pin = false
    },

    no_focus = true
})

-- hl.windowrule({ rule = "opacity 0.9 0.9", match = { class = "^(Rofi)$" } })

-- Smart gaps / No gaps when only (uncomment to enable)
-- hl.workspacerule("w[tv1]", { gapsout = 0, gapsin = 0 })
-- hl.workspacerule("f[1]",   { gapsout = 0, gapsin = 0 })
-- hl.windowrule({ rule = "bordersize 0", match = { floating = 0, onworkspace = "w[tv1]" } })
-- hl.windowrule({ rule = "rounding 0",   match = { floating = 0, onworkspace = "w[tv1]" } })
-- hl.windowrule({ rule = "bordersize 0", match = { floating = 0, onworkspace = "f[1]" } })
-- hl.windowrule({ rule = "rounding 0",   match = { floating = 0, onworkspace = "f[1]" } })
