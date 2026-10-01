local monitors = require("modules.monitors")

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "alacritty"
local fileManager = "thunar"
local menu        = "pidof wofi & pkill wofi || wofi -t=st -S drun -I -n -W 300 -H 700"
local code        = "~/wpilib/2026/vscode/VSCode-linux-x64/code"
local notes       = "xournalpp"
local browser     = "firefox"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Omarchy-style clipboard translation; target the focused surface.
local function sendShortcutOnce(mods, key)
    return function()
        hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))
        hl.timer(function()
            hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
        end, { timeout = 50, type = "oneshot" })
    end
end

local function universalClipboardShortcut(defaultMods, defaultKey, terminalMods, terminalKey)
    return function()
        local window = hl.get_active_window()
        for _, tag in ipairs(window and window.tags or {}) do
            if tag:gsub("%*$", "") == "terminal" then
                sendShortcutOnce(terminalMods, terminalKey)()
                return
            end
        end
        sendShortcutOnce(defaultMods, defaultKey)()
    end
end

hl.bind(mainMod .. " + C", universalClipboardShortcut("CTRL", "C", "CTRL", "Insert"),
    { description = "Universal copy" })
hl.bind(mainMod .. " + V", universalClipboardShortcut("CTRL", "V", "SHIFT", "Insert"),
    { description = "Universal paste" })
hl.bind(mainMod .. " + X", sendShortcutOnce("CTRL", "X"), { description = "Universal cut" })


-- Pass shortcuts through to the focused app until the same chord is pressed again.
local shortcutToggle = mainMod .. " + SHIFT + F12"
hl.bind(shortcutToggle, hl.dsp.submap("shortcuts-disabled"), {
    locked = true,
    description = "Disable Hyprland shortcuts",
})
hl.define_submap("shortcuts-disabled", function()
    hl.bind(shortcutToggle, hl.dsp.submap("reset"), {
        locked = true,
        description = "Enable Hyprland shortcuts",
    })
end)

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(code))
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

-- Forward OBS recording hotkeys globally to its native Wayland window.
local obsWindow = [[class:^(com\.obsproject\.Studio)$]]
hl.bind("CTRL + ALT + SHIFT + Z", hl.dsp.pass({ window = obsWindow }))
hl.bind("CTRL + ALT + SHIFT + X", hl.dsp.pass({ window = obsWindow }))


local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd("systemctl reboot"), { locked = true })
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("systemctl sleep"), { locked = true })
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd("systemctl poweroff"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + D", monitors.useDefaultLayout, { locked = true })
hl.bind(mainMod .. " + ALT + D", monitors.useExternalOnlyLayout)
hl.bind(mainMod .. " + SHIFT + D", monitors.usePresentationLayout)
hl.bind("switch:on:Lid Switch", monitors.useExternalOnlyLayout, { locked = true })
hl.bind("switch:off:Lid Switch", monitors.useDefaultLayout, { locked = true })

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move the focused window in the layout with Super + Shift + arrows.
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- Workspace navigation: Alt views, Ctrl moves a window, Ctrl+Alt moves and follows.
hl.bind(mainMod .. " + ALT + left",  hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.move({ workspace = "-1", follow = false }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ workspace = "+1", follow = false }))
hl.bind(mainMod .. " + CTRL + ALT + left",  hl.dsp.window.move({ workspace = "-1", follow = true }))
hl.bind(mainMod .. " + CTRL + ALT + right", hl.dsp.window.move({ workspace = "+1", follow = true }))

-- Use the same workspace modifiers with number keys (0 selects workspace 10).
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + ALT + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + CTRL + " .. key,     hl.dsp.window.move({ workspace = i, follow = false }))
    hl.bind(mainMod .. " + CTRL + ALT + " .. key,     hl.dsp.window.move({ workspace = i, follow = true }))
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
