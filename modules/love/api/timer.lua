---@meta
---@module 'love.timer'

--- Provides high-resolution timing functionality.
---@class love.timer
love.timer = {}

--- Returns the time between the last two frames.
---@return number dt The time between the last two frames in seconds.
function love.timer.getDelta() end

--- Returns the current frames per second.
---@return number fps The current FPS.
function love.timer.getFPS() end

--- Returns the value of a high-resolution timer.
---@return number time The current time in seconds.
function love.timer.getTime() end

--- Measures the time taken by a function and returns the result.
---@param func function The function to be measured.
---@return number time The time taken by the function in seconds.
function love.timer.measure(func) end

--- Pauses the program for the specified amount of time.
---@param seconds number The amount of time to sleep in seconds.
function love.timer.sleep(seconds) end

--- Step the timer manually, for use in cases when a fixed frame rate is required.
function love.timer.step() end

--- Gets the average delta time over the past second.
---@return number dt The average delta time in seconds.
function love.timer.getAverageDelta() end

return love.timer
