---@meta
---@module 'love.system'

--- Provides access to information about the user's system.
---@class love.system
love.system = {}

--- Gets the current operating system.
---@return love.system.OperatingSystem osString The current operating system.
function love.system.getOS() end

--- Returns the amount of logical processor in the system.
---@return number cores The amount of logical processors.
function love.system.getProcessorCount() end

--- Gets the power supply information.
---@return love.system.PowerState state The basic state of the power supply.
---@return number percent The percentage of battery life left, between 0 and 100. nil if the value can't be determined.
---@return number seconds The seconds of battery life left. nil if the value can't be determined.
function love.system.getPowerInfo() end

--- Causes the game to relaunch itself (and close the old instance).
---@param args string Optional string of command line arguments.
function love.system.restart(args) end

--- Open a URL with the user's web or file browser.
---@param url string The URL to open.
---@return boolean success True if the URL was opened successfully, false otherwise.
function love.system.openURL(url) end

--- Gets the amount of RAM on the system in bytes.
---@return number ram The amount of RAM on the system in bytes.
function love.system.getTotalRAM() end

--- Gets the language and locale of the system.
---@return string language The language and locale of the system.
function love.system.getOSLanguage() end

---@alias love.system.OperatingSystem string
--- Operating systems.
love.system.OperatingSystem = {
    --- Windows.
    "Windows",
    --- Mac OS X.
    "OS X",
    --- Linux.
    "Linux",
    --- Android.
    "Android",
    --- iOS.
    "iOS",
}

---@alias love.system.PowerState string
--- Power states.
love.system.PowerState = {
    --- The system has a battery and is not charging.
    "battery",
    --- The system is plugged in and charging.
    "charging",
    --- The system is plugged in and the battery is fully charged.
    "charged",
    --- The system does not have a battery.
    "nobattery",
    --- The power state cannot be determined.
    "unknown",
}

return love.system
