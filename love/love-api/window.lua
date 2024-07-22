---@meta
---@module 'love.window'

--- Provides an interface for modifying and retrieving information about the program's window.
---@class love.window
love.window = {}

--- Closes the window.
function love.window.close() end

--- Gets the name of the display device.
---@param displaynumber number The index of the display to get the name of.
---@return string name The name of the specified display.
function love.window.getDisplayName(displaynumber) end

--- Gets the number of connected display devices.
---@return number count The number of connected displays.
function love.window.getDisplayCount() end

--- Gets the width and height in pixels of a display.
---@param displaynumber number The index of the display to get the dimensions of.
---@return number width The width of the specified display.
---@return number height The height of the specified display.
function love.window.getDisplayDimensions(displaynumber) end

--- Gets the window's display index.
---@return number index The index of the display that the window is currently in.
function love.window.getDisplayIndex() end

--- Gets the window's height.
---@return number height The height of the window in pixels.
function love.window.getHeight() end

--- Gets the window's width.
---@return number width The width of the window in pixels.
function love.window.getWidth() end

--- Gets the window's position.
---@return number x The x-coordinate of the window's position.
---@return number y The y-coordinate of the window's position.
---@return boolean display Whether the window is in fullscreen mode.
function love.window.getPosition() end

--- Checks if the window is fullscreen.
---@return boolean fullscreen True if the window is fullscreen, false otherwise.
function love.window.isFullscreen() end

--- Checks if the window is maximized.
---@return boolean maximized True if the window is maximized, false otherwise.
function love.window.isMaximized() end

--- Checks if the window is minimized.
---@return boolean minimized True if the window is minimized, false otherwise.
function love.window.isMinimized() end

--- Checks if the window is visible.
---@return boolean visible True if the window is visible, false otherwise.
function love.window.isVisible() end

--- Maximizes the window.
function love.window.maximize() end

--- Minimizes the window.
function love.window.minimize() end

--- Restores the window.
function love.window.restore() end

--- Sets the window's title.
---@param title string The new title for the window.
function love.window.setTitle(title) end

--- Sets the window's mode.
---@param width number The new width of the window.
---@param height number The new height of the window.
---@param flags table A table with fullscreen, vsync, resizable, borderless, centered, display, minwidth, minheight, and highdpi fields.
---@return boolean success True if the window mode was set successfully, false otherwise.
function love.window.setMode(width, height, flags) end

--- Sets whether the window is fullscreen.
---@param fullscreen boolean Whether to set the window to fullscreen.
---@return boolean success True if the window was set to fullscreen, false otherwise.
function love.window.setFullscreen(fullscreen) end

--- Sets the window's position.
---@param x number The new x-coordinate of the window's position.
---@param y number The new y-coordinate of the window's position.
---@param display number The display index to use.
function love.window.setPosition(x, y, display) end

--- Shows the window.
function love.window.show() end

--- Hides the window.
function love.window.hide() end

---@alias love.window.DisplayOrientation string
--- Display orientations.
love.window.DisplayOrientation = {
    --- Unknown orientation.
    "unknown",
    --- Portrait orientation.
    "portrait",
    --- Landscape orientation.
    "landscape",
    --- Portrait upside-down orientation.
    "portraitflipped",
    --- Landscape upside-down orientation.
    "landscapeflipped",
}

return love.window
