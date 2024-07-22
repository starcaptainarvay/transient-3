---@meta
---@module 'love.touch'

--- Provides an interface to touch-screen presses.
---@class love.touch
love.touch = {}

--- Gets the current position of the specified touch-press.
---@param id lightuserdata The identifier of the touch-press.
---@return number x The x-coordinate of the touch-press.
---@return number y The y-coordinate of the touch-press.
---@return number pressure The pressure of the touch-press.
function love.touch.getPosition(id) end

--- Gets the pressure of the specified touch-press.
---@param id lightuserdata The identifier of the touch-press.
---@return number pressure The pressure of the touch-press.
function love.touch.getPressure(id) end

--- Gets a list of all active touch-presses.
---@return table ids A list of identifiers of active touch-presses.
function love.touch.getTouches() end

return love.touch
