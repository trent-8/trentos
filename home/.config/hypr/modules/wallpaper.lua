-------------------
---- WALLPAPER ----
-------------------

local wallpaperDirectory = "/usr/share/wallpapers"
local wallpaperInterval = 120000
local wallpaperStartupDelay = 3000
local wallpaperQueue = {}
local lastWallpaper = nil

local singleQuote = string.char(39)
local escapedQuote = singleQuote .. string.char(92) .. singleQuote .. singleQuote

local function shellQuote(value)
    return singleQuote .. value:gsub(singleQuote, escapedQuote) .. singleQuote
end

local function listWallpapers()
    local command = "find " .. shellQuote(wallpaperDirectory) .. " -maxdepth 1 -type f -print"
    local process = io.popen(command, "r")
    if process == nil then
        return {}
    end

    local wallpapers = {}
    for path in process:lines() do
        local extension = path:lower():match("%.([^.]+)$")
        if extension == "jpg" or extension == "jpeg" or extension == "png" then
            table.insert(wallpapers, path)
        end
    end
    process:close()
    return wallpapers
end

local function activeWallpaper()
    local process = io.popen("hyprctl hyprpaper listactive", "r")
    if process == nil then
        return nil
    end

    local output = process:read("*a")
    process:close()

    local firstLine = output:match("([^\r\n]+)")
    return firstLine and firstLine:match("^[^:]+:%s*(.-)%s*$")
end

local function shuffle(items)
    for i = #items, 2, -1 do
        local j = math.random(i)
        items[i], items[j] = items[j], items[i]
    end
end

local function refillWallpaperQueue()
    wallpaperQueue = listWallpapers()
    shuffle(wallpaperQueue)

    if #wallpaperQueue > 1 and wallpaperQueue[#wallpaperQueue] == lastWallpaper then
        wallpaperQueue[1], wallpaperQueue[#wallpaperQueue] = wallpaperQueue[#wallpaperQueue], wallpaperQueue[1]
    end
end

local function setNextWallpaper()
    if #wallpaperQueue == 0 then
        lastWallpaper = activeWallpaper()
        refillWallpaperQueue()
    end

    if #wallpaperQueue == 0 then
        hl.notification.create({
            text = "No JPG, JPEG, or PNG wallpapers found in " .. wallpaperDirectory,
            timeout = 8000,
            icon = "warning",
        })
        return
    end

    lastWallpaper = table.remove(wallpaperQueue)
    local request = ", " .. lastWallpaper .. ", cover"
    hl.exec_cmd("hyprctl hyprpaper wallpaper " .. shellQuote(request))
end

math.randomseed(os.time())
hl.timer(function()
    setNextWallpaper()
    hl.timer(setNextWallpaper, { timeout = wallpaperInterval, type = "repeat" })
end, { timeout = wallpaperStartupDelay, type = "oneshot" })
