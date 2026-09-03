
------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1200@60",
    position = "0x0",
    scale    = "1.5",
})

hl.monitor({
    output   = "desc:Crestron Electronics Inc. Crestron",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
    mirror   = "eDP-1",
})

hl.monitor({
    output   = "desc:LG Electronics LG HDR QHD 303NTHM4B113",
    mode     = "highres@highrr",
    position = "auto-center-up",
    scale    = "1.25",
})

hl.monitor({
    output   = "desc:LG Electronics LG ULTRAGEAR 111NTUW3H478",
    mode     = "highres@highrr",
    position = "auto-center-up",
    scale    = "1.25",
})

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto-center-up",
    scale    = "auto",
})


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "alacritty"
local fileManager = "thunar"
local menu        = "pidof wofi & pkill wofi || wofi -t=st -S drun -I -n -W 300 -H 700"
local code        = "~/wpilib/2026/vscode/VSCode-linux-x64/code"
local notes       = "xournalpp"
local browser     = "firefox"

local function enableLaptopMonitor()
    hl.monitor({ output = "eDP-1", mode = "1920x1200@60", position = "0x0", scale = 1.5, disabled = false })
end

local function disableLaptopMonitor()
    hl.monitor({ output = "eDP-1", disabled = true })
end


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function ()
  hl.exec_cmd("dunst &")
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("quickshell -p ~/.config/quickshell/trentos")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("sleep 1 && megasync")
  hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
  hl.exec_cmd("~/scripts/orientation-manager")
  hl.exec_cmd("/usr/bin/kdeconnectd")
  hl.exec_cmd("thunar --daemon")
  hl.exec_cmd("twingate service-start")
  hl.exec_cmd("twingate desktop-start")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("XCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_SIZE", "32")
hl.env("XCURSOR_THEME", "macos-tahoe-cursor")
hl.env("TERMINAL", "alacritty")
hl.env("EDITOR", "nvim")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    xwayland = {
        force_zero_scaling = true,
    },

    general = {
        gaps_in  = 2,
        gaps_out = 3,

        border_size = 1,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 7,
        rounding_power = 4.6,

        blur = {
            enabled           = true,
            size              = 2,
            passes            = 1,
            new_optimizations = true,
            noise             = 0.012,
            contrast          = 0.92,
            brightness        = 0.82,
            vibrancy          = 0.10,
        },
    },

    animations = {
        enabled = false,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        background_color         = "rgb(202020)"
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
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


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(code))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("codex-desktop"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + I", function()
    hl.dispatch(hl.dsp.focus({ window = "class:firefox" }))
    hl.dispatch(hl.dsp.exec_cmd(browser .. " https://dordt.instructure.com/"))
end)
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(notes))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(terminal .. " -e bluetuith --adapter-states=\"scan:yes\""))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal .. " -e btop"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("grim -g \"$(slurp -d)\" - | tee ~/MEGA/Pictures/$(date +\"%Y%m%d_%Hh%Mm%Ss\")_grim.png | wl-copy"))


local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd("systemctl reboot"), { locked = true })
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("systemctl sleep"), { locked = true })
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd("systemctl poweroff"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + D", disableLaptopMonitor)
hl.bind(mainMod .. " + ALT + D", enableLaptopMonitor, { locked = true })

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move workspaces with arrow keys
hl.bind(mainMod .. " + ALT + left",  hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ workspace = "-1", follow = false }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ workspace = "+1", follow = false }))
hl.bind(mainMod .. " + ALT + SHIFT + left",  hl.dsp.window.move({ workspace = "-1", follow = true }))
hl.bind(mainMod .. " + ALT + SHIFT + right", hl.dsp.window.move({ workspace = "+1", follow = true }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + ALT + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i, follow = false }))
    hl.bind(mainMod .. " + ALT + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i, follow = true }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl --min-value=1000 --save set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl --min-value=1000 --save set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86Favorites",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86Calculator",  hl.dsp.exec_cmd("mate-calc"),   { locked = true })

-- TODO: make a submap which disables all keybinds which automatically gets enabled when QEMU or rustdesk is focused


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

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
