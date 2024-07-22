---@meta
---@module 'love.joystick'

--- Provides an interface to connected joysticks.
---@class love.joystick
love.joystick = {}

--- Gets the list of connected Joysticks.
---@return table joysticks A table containing all currently connected Joysticks.
function love.joystick.getJoysticks() end

--- Gets the number of connected joysticks.
---@return number count The number of currently connected joysticks.
function love.joystick.getJoystickCount() end

--- Checks if joystick module is supported.
---@return boolean supported True if the joystick module is supported, false otherwise.
function love.joystick.isSupported() end

--- Loads a Joystick configuration file.
---@param filename string The name of the configuration file.
---@return boolean success True if the configuration was successfully loaded, false otherwise.
function love.joystick.loadGamepadMappings(filename) end

---@class love.joystick.Joystick
local Joystick = {}

--- Checks if the Joystick is connected.
---@return boolean connected True if the Joystick is connected, false otherwise.
function Joystick:isConnected() end

--- Gets the number of axes on the Joystick.
---@return number count The number of axes on the Joystick.
function Joystick:getAxisCount() end

--- Gets the current position of an axis.
---@param axis number The axis number.
---@return number position The current position of the axis.
function Joystick:getAxis(axis) end

--- Gets the number of buttons on the Joystick.
---@return number count The number of buttons on the Joystick.
function Joystick:getButtonCount() end

--- Checks if a button on the Joystick is pressed.
---@param button number The button number.
---@return boolean pressed True if the button is pressed, false otherwise.
function Joystick:isDown(button) end

--- Gets the number of hats on the Joystick.
---@return number count The number of hats on the Joystick.
function Joystick:getHatCount() end

--- Gets the current direction of a hat.
---@param hat number The hat number.
---@return love.joystick.Hat direction The direction of the hat.
function Joystick:getHat(hat) end

--- Gets the name of the Joystick.
---@return string name The name of the Joystick.
function Joystick:getName() end

--- Gets the GUID of the Joystick.
---@return string guid The GUID of the Joystick.
function Joystick:getGUID() end

--- Gets the type of the Joystick.
---@return love.joystick.Type type The type of the Joystick.
function Joystick:getType() end

---@alias love.joystick.Hat string
--- The direction of a joystick hat.
love.joystick.Hat = {
    --- Centered position.
    "c",
    --- Up.
    "u",
    --- Down.
    "d",
    --- Left.
    "l",
    --- Right.
    "r",
    --- Up-left.
    "ul",
    --- Up-right.
    "ur",
    --- Down-left.
    "dl",
    --- Down-right.
    "dr",
}

---@alias love.joystick.Type string
--- The type of a joystick.
love.joystick.Type = {
    --- Gamepad.
    "gamepad",
    --- Wheel.
    "wheel",
    --- Joystick.
    "joystick",
    --- Dancepad.
    "dancepad",
    --- Guitar.
    "guitar",
    --- Drumkit.
    "drumkit",
    --- Arcade stick.
    "arcadestick",
}

return love.joystick
