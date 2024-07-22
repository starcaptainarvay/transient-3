---@meta
---@module 'love.keyboard'

--- Provides an interface to the user's keyboard.
---@class love.keyboard
love.keyboard = {}

--- Checks whether a certain key is down.
---@param key love.keyboard.KeyConstant The key to check.
---@return boolean down True if the key is down, false if it isn't.
function love.keyboard.isDown(key) end

--- Checks whether repeat keypresses are enabled.
---@return boolean enabled Whether repeat keypresses are enabled.
function love.keyboard.hasKeyRepeat() end

--- Checks if key repeat is enabled.
---@return boolean enabled True if key repeat is enabled, false otherwise.
function love.keyboard.hasTextInput() end

--- Enables or disables key repeat.
---@param enable boolean Whether repeat keypresses should be enabled.
function love.keyboard.setKeyRepeat(enable) end

--- Enables or disables text input events.
---@param enable boolean Whether text input events should be enabled.
function love.keyboard.setTextInput(enable) end

--- Gets the current text input state.
---@return boolean enabled Whether text input is enabled.
function love.keyboard.hasTextInput() end

---@alias love.keyboard.KeyConstant string
--- Keyboard key constants.
love.keyboard.KeyConstant = {
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n",
    "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1",
    "2", "3", "4", "5", "6", "7", "8", "9", "kp0", "kp1", "kp2", "kp3",
    "kp4", "kp5", "kp6", "kp7", "kp8", "kp9", "kp.", "kp,", "kpenter",
    "kp+", "kp-", "kp*", "kp/", "f1", "f2", "f3", "f4", "f5", "f6", "f7",
    "f8", "f9", "f10", "f11", "f12", "left", "right", "up", "down",
    "home", "end", "pageup", "pagedown", "insert", "backspace", "tab",
    "clear", "return", "pause", "escape", "space", "!", "\"", "#", "$", "%",
    "&", "'", "(", ")", "*", "+", ",", "-", ".", "/", ":", ";", "<", "=",
    ">", "?", "@", "[", "\\", "]", "^", "_", "`", "{", "|", "}", "~", "capslock",
    "scrolllock", "numlock", "printscreen", "menu", "lctrl", "lshift",
    "lalt", "lgui", "rctrl", "rshift", "ralt", "rgui",
}

return love.keyboard
