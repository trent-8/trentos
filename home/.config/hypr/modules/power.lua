--------------------------
---- POWER MANAGEMENT ----
--------------------------

local batteryPath = "/sys/class/power_supply/BAT0"
local lowBatteryThreshold = 5
local lowBatteryNotificationInterval = 120
local lastLowBatteryNotification = 0

local function readBatteryValue(name)
    local batteryFile = io.open(batteryPath .. "/" .. name, "r")
    if batteryFile == nil then
        return nil
    end

    local value = batteryFile:read("*l")
    batteryFile:close()
    return value
end

local function checkLowBattery()
    local capacity = tonumber(readBatteryValue("capacity"))
    local status = readBatteryValue("status")
    if capacity == nil or status ~= "Discharging" or capacity >= lowBatteryThreshold then
        return
    end

    local now = os.time()
    if now - lastLowBatteryNotification < lowBatteryNotificationInterval then
        return
    end

    lastLowBatteryNotification = now
    hl.notification.create({
        text = "Low battery: " .. capacity .. "% remaining",
        timeout = 10000,
        color = "rgb(ff8c8c)",
        icon = "warning",
    })
end

checkLowBattery()
hl.timer(checkLowBattery, { timeout = 10000, type = "repeat" })

