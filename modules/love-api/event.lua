---@meta

---@module 'love.event'

--- Manages events, like keypresses.
---@class love.event
love.event = {}

--- Clears the event queue.
function love.event.clear() end

--- Pump events into the event queue.
--- This is a low-level function, and is usually not called by the user, but by love.run().
function love.event.pump() end

--- Adds an event to the queue.
---@param name love.event.Event The name of the event.
---@vararg any Additional arguments to the event.
function love.event.push(name, ...) end

--- Adds quit event to the queue.
--- The default action is to close the LÖVE window. This function will call any registered quit callbacks before the application closes.
---@param exitstatus number An optional integer that signals the program should exit with a specific status code.
function love.event.quit(exitstatus) end

--- Returns an iterator for the event queue.
--- The iterator returns an event name followed by its arguments.
---@return function iterator The iterator function usable in a for loop.
function love.event.poll() end

--- Wait for and returns the next event in the queue.
--- This is the same as love.event.poll, but it blocks until there is an event in the queue.
---@return love.event.Event name The name of the event.
---@vararg any Additional arguments to the event.
function love.event.wait() end

---@alias love.event.Event string
--- Event types.
love.event.Event = {
    --- Event triggered when the window is closed.
    "quit",
    --- Event triggered when a key is pressed.
    "keypressed",
    --- Event triggered when a key is released.
    "keyreleased",
    --- Event triggered when a mouse button is pressed.
    "mousepressed",
    --- Event triggered when a mouse button is released.
    "mousereleased",
    --- Event triggered when the mouse is moved.
    "mousemoved",
    --- Event triggered when the mouse wheel is moved.
    "wheelmoved",
    --- Event triggered when the window is resized.
    "resize",
    --- Event triggered when the window gains focus.
    "focus",
    --- Event triggered when the window loses focus.
    "blur",
    --- Event triggered when text is entered.
    "textinput",
    --- Event triggered when a joystick axis is moved.
    "joystickaxis",
    --- Event triggered when a joystick button is pressed.
    "joystickpressed",
    --- Event triggered when a joystick button is released.
    "joystickreleased",
    --- Event triggered when a joystick is added.
    "joystickadded",
    --- Event triggered when a joystick is removed.
    "joystickremoved",
    --- Event triggered when the window is exposed.
    "visible",
    --- Event triggered when the window is hidden.
    "hidden",
    --- Event triggered when the window is minimized.
    "minimized",
    --- Event triggered when the window is maximized.
    "maximized",
    --- Event triggered when the window is restored.
    "restored",
    --- Event triggered when the window enters fullscreen mode.
    "enterfullscreen",
    --- Event triggered when the window exits fullscreen mode.
    "exitfullscreen",
}

return love.event