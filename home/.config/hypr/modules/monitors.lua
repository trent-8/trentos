local M = {}
local currentLayout = nil


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
local function configureLgHdr(position)
    hl.monitor({
        output        = "desc:LG Electronics LG HDR QHD 303NTHM4B113",
        mode          = "2560x1440@60",
        position      = position,
        scale         = "1.25",
        bitdepth      = 10,
        cm            = "auto",
        sdrbrightness = 1.2,
        sdrsaturation = 1.0,
    })
end

function M.useDefaultLayout()
    currentLayout = "default"
    hl.monitor({
        output   = "eDP-1",
        mode     = "1920x1200@60",
        position = "0x0",
        scale    = "1.5",
        disabled = false,
    })

    hl.monitor({
        output   = "desc:Crestron Electronics Inc. Crestron",
        mode     = "preferred",
        position = "auto-center-up",
        scale    = "auto",
    })

    configureLgHdr("auto-center-up")

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
 end

function M.useExternalOnlyLayout()
    currentLayout = "external-only"
    hl.monitor({ output = "eDP-1", disabled = true })

    hl.monitor({
        output   = "desc:Crestron Electronics Inc. Crestron",
        mode     = "preferred",
        position = "auto",
        scale    = "auto",
    })

    configureLgHdr("0x0")

    hl.monitor({
        output   = "desc:LG Electronics LG ULTRAGEAR 111NTUW3H478",
        mode     = "highres@highrr",
        position = "0x0",
        scale    = "1.25",
    })

    hl.monitor({
        output   = "",
        mode     = "preferred",
        position = "auto-center-up",
        scale    = "auto",
    })
end

function M.usePresentationLayout()
    currentLayout = "presentation"
    hl.monitor({
        output   = "eDP-1",
        mode     = "1920x1080@60",
        position = "0x0",
        scale    = "1.5",
        disabled = false,
    })

    hl.monitor({
        output   = "desc:Crestron Electronics Inc. Crestron",
        mode     = "1920x1080@60",
        position = "auto",
        scale    = "1.5",
        mirror   = "eDP-1",
    })

    configureLgHdr("auto-center-up")

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
end

M.useDefaultLayout()


local lidStatePath = "/proc/acpi/button/lid/LID0/state"

local function isLaptopLidClosed()
    local lidStateFile = io.open(lidStatePath, "r")
    if lidStateFile == nil then
        return false
    end

    local lidState = lidStateFile:read("*l")
    lidStateFile:close()
    return lidState ~= nil and lidState:find("closed", 1, true) ~= nil
end

hl.timer(function()
    -- Track the selected layout so a closed lid does not reapply it every second.
    if isLaptopLidClosed() and currentLayout ~= "external-only" then
        M.useExternalOnlyLayout()
    end
end, { timeout = 1000, type = "repeat" })


return M
