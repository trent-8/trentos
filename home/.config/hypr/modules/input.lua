---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "caps:swapescape",
        kb_rules   = "",
        follow_mouse = 1,
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
        natural_scroll = true,
        accel_profile = "custom 1.0 0.0 0.75",
        scroll_factor = 0.5,
        touchdevice = {
            output = "eDP-1",
        },
        tablet = {
            output = "eDP-1",
        },
        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.07,
            disable_while_typing = false,
        },
    },
    gestures = {
        workspace_swipe_touch = true,
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
