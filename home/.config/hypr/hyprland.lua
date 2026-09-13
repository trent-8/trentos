-- TrentOS Hyprland configuration
-- Each module groups one area of the desktop configuration.

local function loadModule(name)
    package.loaded[name] = nil
    require(name)
end

loadModule("modules.monitors")    -- Monitor layouts, lid handling, and display controls
loadModule("modules.power")       -- Battery monitoring and low-power notifications
loadModule("modules.autostart")   -- Programs started with Hyprland
loadModule("modules.wallpaper")   -- Random, non-repeating wallpaper rotation
loadModule("modules.environment") -- Environment variables and permissions
loadModule("modules.appearance")  -- Layouts, decoration, blur, and miscellaneous visuals
loadModule("modules.input")       -- Keyboard, pointer, touch, and gestures
loadModule("modules.keybindings") -- Application, workspace, system, and media shortcuts
loadModule("modules.rules")       -- Window and layer rules
