-- input.lua
-- Keyboard, mouse, touchpad, and gesture configuration
-- Replaces input.conf

-- https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    input = {
        kb_layout     = "us",
        follow_mouse  = 1,
        repeat_rate   = 50,
        repeat_delay  = 300,
        sensitivity   = 0,           -- -1.0 to 1.0, 0 means no modification
        accel_profile = "flat",

        touchpad = {
            natural_scroll = true,
        },
    },
})

-- Per-device config
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
hl.device({
    name        = "logitech-g-pro--1",
    sensitivity = 0,
})

-- Gestures
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
