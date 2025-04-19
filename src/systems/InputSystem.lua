local wf = require("workflower")
local t3 = require("transient")

local InputSystem = t3.system("Input")

local InputEvent = wf.observable()
local KeysDown = {}

function InputSystem:init(component, entity)

end

function love.keypressed(key, scanCode, isRepeat)
    KeysDown[key] = true
    InputEvent:dispatch("down", key, scanCode, isRepeat)
end

function love.keyreleased(key, scanCode, isRepeat)
    KeysDown[key] = false
    InputEvent:dispatch("up", key, scanCode, isRepeat)
end

function InputSystem:on(...)
    return InputEvent:on(...)
end

function InputSystem:once(...)
    return InputEvent:once(...)
end

return InputSystem