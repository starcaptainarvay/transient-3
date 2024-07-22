---@meta
---@module 'love.thread'

--- Provides a basic framework for multithreaded programming.
---@class love.thread
love.thread = {}

--- Creates a new Channel.
---@param name string The name of the channel.
---@return love.thread.Channel channel The new Channel.
function love.thread.newChannel(name) end

--- Creates a new Thread from a File or Data object.
---@param filename string The filename of the Lua script to run in the thread.
---@return love.thread.Thread thread The new Thread.
function love.thread.newThread(filename) end

---@class love.thread.Channel
local Channel = {}

--- Clears all messages in the Channel.
function Channel:clear() end

--- Gets the count of messages in the Channel.
---@return number count The number of messages in the Channel.
function Channel:getCount() end

--- Gets a message from the Channel.
---@param wait number The maximum time to wait, in seconds.
---@return any message The message, or nil if the Channel is empty.
function Channel:pop(wait) end

--- Sends a message to the Channel.
---@param message any The message to send.
function Channel:push(message) end

--- Peeks at the first message in the Channel.
---@return any message The first message in the Channel, or nil if the Channel is empty.
function Channel:peek() end

--- Performs an atomic 'get and remove' operation on the Channel.
---@param wait number The maximum time to wait, in seconds.
---@return any message The message, or nil if the Channel is empty.
function Channel:demand(wait) end

--- Sends a message to the Channel and waits for a thread to receive it.
---@param message any The message to send.
function Channel:supply(message) end

--- Gets a message from the Channel and waits for a message to be available.
---@return any message The message, or nil if the Channel is empty.
function Channel:pop() end

--- Sends a message to the Channel.
---@param message any The message to send.
function Channel:push(message) end

---@class love.thread.Thread
local Thread = {}

--- Starts the thread.
function Thread:start() end

--- Waits for the thread to finish.
---@param timeout number The maximum time to wait, in seconds.
---@return boolean finished True if the thread has finished, false if the timeout expired.
function Thread:wait(timeout) end

--- Gets the error message from the thread.
---@return string message The error message.
function Thread:getError() end

--- Sets the error message for the thread.
---@param message string The error message.
function Thread:setError(message) end

---@alias love.thread.ThreadStatus string
--- The status of the thread.
love.thread.ThreadStatus = {
    --- The thread is not running.
    "notrunning",
    --- The thread is running.
    "running",
    --- The thread has finished running.
    "finished",
    --- The thread has an error.
    "error",
}

return love.thread
