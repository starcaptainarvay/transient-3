local wf = require("workflower")
local t3 = require("transient")

local Shader = require("systems.rendering.shader")
print("shader loaded")

local vector = require("src.math.vector")
print("vector loaded")

local InputSystem = t3.system("Input") -- import InputSystem
local RenderSystem = t3.system("Render")
local renderQueue, renderQueueCell

--[[ ADJUSTABLE BOUNDS: ]]

    local AdjustingOn, setAdjustingOn = wf.bucket(nil, false)
    local dimensions, center, offset

    local KEY_ADJUST_MODE = "tab"
    local KEY_VECS = {
        up = vector.new(0, 1),
        down = vector.new(0, -1),
        right = vector.new(1, 0),
        left = vector.new(-1, 0)
    }

    local ADJUST_SCALE = 1

    local function IsAdjusting()
        local pressed_adjustment_key = false

        for key, value in pairs(KEY_VECS) do
            if love.keyboard.isDown(key) then
                pressed_adjustment_key = true

                local k = 1
                if key == "up" or key == "down" then
                    k = -1
                end
                if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
                    dimensions = dimensions + (k * value * ADJUST_SCALE)
                    center = (dimensions/2):floor()
                else
                    offset = offset + (k * value * ADJUST_SCALE)
                end
            end
        end

        return pressed_adjustment_key
    end

--[[ END ]]

function RenderSystem:init(component, entity)

end

function RenderSystem:initSystem()
    dimensions = vector.new(1920, 1080)
    center = (dimensions/2):floor()

    local width, height = love.window.getMode()
    offset = ((vector.new(width, height) - dimensions)/2):floor()

    InputSystem:on("down", function(key)
        if key ~= KEY_ADJUST_MODE then return end
        AdjustingOn:set(not AdjustingOn:get())
    end)
end

function RenderSystem:update(component, entity)
    print('updawg')
end

function RenderSystem:preUpdate()
    -- love.graphics.setColor(0, 0, 0, 1)
    -- love.graphics.clear()
end

function RenderSystem:updateSystem()
    love.graphics.setColor(0, 1, 0, 1)

    if AdjustingOn:get() then
        if IsAdjusting() then
            love.graphics.setColor(1, .7, .2, 1)
            print(dimensions, center + offset)
        end

        renderQueueCell({ "rect", 10, { offset, dimensions } })
    end
end

local function rect(line_width, dim)
    local pos, size = unpack(dim)

    love.graphics.setLineWidth(line_width)
    love.graphics.rectangle("line", pos.x, pos.y, size.x, size.y)
end

function RenderSystem.drawTexture(object, ...)
    if object == "rect" then
        rect(...)
    end
end

function RenderSystem.createQueue()
    if not renderQueue then
       renderQueue, renderQueueCell = wf.queue()
    end
    return renderQueue, renderQueueCell, RenderSystem.drawTexture
end


-- local a = vector.new(3, 3)
-- local b = vector.new(1, 2)

-- print("a * b", a * b)
-- print("a * 5", a * 5)
-- print("5 * a", 5 * a)
-- print("a + b", a + b)
-- print("2 * b * 2", 2 * b * 2)

return RenderSystem