--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

-- Shared terminal classification for universal clipboard shortcuts.
hl.window_rule({
    name = "tag-terminal-windows",
    match = { class = [[(Alacritty|kitty|com\.mitchellh\.ghostty|foot|org\.codeberg\.dnkl\.foot|wezterm|org\.wezfurlong\.wezterm)]] },
    tag = "+terminal",
})

-- Double the global mouse (0.5) and touchpad (0.07) scroll factors in Alacritty.
hl.window_rule({
    name = "alacritty-scroll-speed",
    match = { class = "Alacritty" },
    scroll_mouse = 1.0,
    scroll_touchpad = 0.14,
})

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
local selectionLayerRule = hl.layer_rule({
    name  = "no-anim-for-selection",
    match = { namespace = "selection" },
    no_anim = true,
})
selectionLayerRule:set_enabled(true)

local hyprpickerLayerRule = hl.layer_rule({
    name  = "no-anim-for-hyprpicker",
    match = { namespace = "hyprpicker" },
    no_anim = true,
})
hyprpickerLayerRule:set_enabled(true)

local trentosBarLayerRule = hl.layer_rule({
    name  = "blur-trentos-bar",
    match = { namespace = "trentos-bar" },

    blur         = true,
    ignore_alpha = 0.2,
})
trentosBarLayerRule:set_enabled(true)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
