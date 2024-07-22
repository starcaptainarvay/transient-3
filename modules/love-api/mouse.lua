---@meta
---@module 'love.mouse'

--- Provides an interface to the user's mouse.
---@class love.mouse
love.mouse = {}

--- Gets whether cursor is visible.
---@return boolean visible True if the cursor is visible, false otherwise.
function love.mouse.isVisible() end

--- Sets whether cursor is visible.
---@param visible boolean True to set the cursor visible, false to hide it.
function love.mouse.setVisible(visible) end

--- Gets the current position of the mouse.
---@return number x The x-coordinate of the mouse.
---@return number y The y-coordinate of the mouse.
function love.mouse.getPosition() end

--- Sets the current position of the mouse.
---@param x number The new x-coordinate of the mouse.
---@param y number The new y-coordinate of the mouse.
function love.mouse.setPosition(x, y) end

--- Gets the current x-coordinate of the mouse.
---@return number x The current x-coordinate of the mouse.
function love.mouse.getX() end

--- Gets the current y-coordinate of the mouse.
---@return number y The current y-coordinate of the mouse.
function love.mouse.getY() end

--- Sets the current x-coordinate of the mouse.
---@param x number The new x-coordinate of the mouse.
function love.mouse.setX(x) end

--- Sets the current y-coordinate of the mouse.
---@param y number The new y-coordinate of the mouse.
function love.mouse.setY(y) end

--- Gets whether the cursor is grabbed.
---@return boolean grabbed True if the cursor is grabbed, false otherwise.
function love.mouse.isGrabbed() end

--- Sets whether the cursor is grabbed.
---@param grabbed boolean True to grab the cursor, false to release it.
function love.mouse.setGrabbed(grabbed) end

--- Gets the current cursor.
---@return love.mouse.Cursor cursor The current cursor, or nil if no cursor is set.
function love.mouse.getCursor() end

--- Sets the current cursor.
---@param cursor love.mouse.Cursor The new cursor to use, or nil to use the default cursor.
function love.mouse.setCursor(cursor) end

--- Creates a new hardware Cursor.
---@param image love.image.ImageData The image data to use for the cursor.
---@param hotx number The x-coordinate of the cursor's hot spot.
---@param hoty number The y-coordinate of the cursor's hot spot.
---@return love.mouse.Cursor cursor The new Cursor object.
function love.mouse.newCursor(image, hotx, hoty) end

--- Checks whether a certain mouse button is down.
---@param button love.mouse.Button The button to check.
---@return boolean down True if the button is down, false if it isn't.
function love.mouse.isDown(button) end

--- Gets the relative position of the mouse.
---@return number dx The relative x-coordinate.
---@return number dy The relative y-coordinate.
function love.mouse.getRelativePosition() end

--- Sets whether relative mode is enabled for the mouse.
---@param enable boolean True to enable relative mode, false to disable it.
function love.mouse.setRelativeMode(enable) end

--- Gets whether relative mode is enabled for the mouse.
---@return boolean enabled True if relative mode is enabled, false otherwise.
function love.mouse.getRelativeMode() end

---@class love.mouse.Cursor
local Cursor = {}

---@alias love.mouse.Button number
--- The mouse buttons.
love.mouse.Button = {
    --- The left mouse button.
    1,
    --- The right mouse button.
    2,
    --- The middle mouse button.
    3,
    --- The fourth mouse button.
    4,
    --- The fifth mouse button.
    5,
}

return love.mouse
