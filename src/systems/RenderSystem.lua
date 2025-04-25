local wf = require("workflower")
local t3 = require("transient")
local dict = require("transient.util.dict")

local Renderables = require("src.renderables")

local Shader = require("systems.rendering.shader")
print("shader loaded")

local vector = require("src.math.vector")
print("vector loaded")

local InputSystem = t3.system("Input") -- import InputSystem
local RenderSystem = t3.system("Render")
local renderQueue, renderQueueCell

--[[ ADJUSTABLE BOUNDS: ]]

    local AdjustingOn, setAdjustingOn = wf.bucket(nil, false)
    local dimensions = vector.new(1920, 1080)
    local center, offset

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
                    local projected = dimensions + (k * value * ADJUST_SCALE)
                    local MIN_DIMENSION_SIZE = 200

                    if dimensions.x < MIN_DIMENSION_SIZE or
                        dimensions.y < MIN_DIMENSION_SIZE then
                        if projected.magnitude < dimensions.magnitude then
                            return pressed_adjustment_key
                        end
                    end

                    dimensions = projected
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
    component.created = love.timer.getTime()
    component.now = component.created
    component.argv = component.argv or {}

    if not component.renderable then
        error("RenderSystem: No renderable provided")
    end
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

    local RenderSystemLocalEntity = t3.entity()

    RenderSystem.DebugBoundingRect = {
        renderable = "rect",
        size = dimensions,
        position = vector.new(0, 0),
        -- shaders = { "test" },
        -- shaders = { "test2" },
        argv = { 10, nil, nil } -- linewidth, stroke color, fill color
    }

    RenderSystem.DebugCenterDot = {
        renderable = "point",
        size = vector.new(3, 3),
        position = vector.new(0, 0),
        shaders = { "test" },
        argv = { 10 } -- linewidth
    }

    t3.addComponent(RenderSystemLocalEntity, "Render", RenderSystem.DebugBoundingRect)
    t3.addComponent(RenderSystemLocalEntity, "Render", RenderSystem.DebugCenterDot)

    setAdjustingOn(false)
end

function RenderSystem:update(component, entity)
    if component.Enabled == false then return end

    local currentTime = love.timer.getTime()
    component.delta = currentTime - component.now
    component.now = currentTime

    local renderObject = {}

    if component.size then
        renderObject.size = component.size

        if component.position then
            -- Adjust position to center the anchor point
            renderObject.position = component.position - (component.size / 2)
        end
    elseif component.position then
        renderObject.position = component.position
    end

    -- Convert position to absolute coordinates before queuing
    if renderObject.position then
        renderObject.position = renderObject.position + center + offset
    end

    if component.shaders then
        renderObject.shaders = {}

        for _, shaderName in pairs(component.shaders) do
            renderObject.shaders[shaderName] = {
                name = shaderName,
                tick = component.now - component.created,
                delta = component.delta,
                intensity = component.intensity, -- default 1
                force = component.force, -- default 0
                screen_offset = {renderObject.position.x, renderObject.position.y} 
            }

            if component.shaderParams then
                renderObject.shaders[shaderName] = dict.merge(renderObject.shaders[shaderName], component.shaderParams)
            end
        end
    end

    renderQueueCell({
        renderObject,
        component.renderable,

        -- Renderable args:
            renderObject.size,
            renderObject.position,
            unpack(component.argv or {})
    })

    if component.expiry then
        if component.now - component.created > component.expiry then
            t3.removeComponent(entity, component)
        end
    end
end

function RenderSystem:preUpdate()
    -- love.graphics.setColor(0, 0, 0, 1)
    -- love.graphics.clear()
end

function RenderSystem:updateSystem(dt)
    RenderSystem.DebugBoundingRect.Enabled = AdjustingOn:get()
    RenderSystem.DebugCenterDot.Enabled = AdjustingOn:get()

    if AdjustingOn:get() then
        RenderSystem.DebugBoundingRect.argv[2] = {0, 1, 0, 1}

        if IsAdjusting() then
            RenderSystem.DebugBoundingRect.argv[2] = {1, .7, .2, 1}
        end

        -- print(dimensions, offset, center)

        RenderSystem.DebugBoundingRect.size = dimensions

        -- renderQueueCell({ {
        --     position = vector.new(),
        --     size = dimensions
        --     -- shaders = {
        --     --     test = {
        --     --         name = "test",
        --     --         tick = os.time() % 10
        --     --     }
        --     -- }
        -- }, "rect", 10})

        self:update(RenderSystem.DebugBoundingRect, RenderSystem.DebugBoundingRect.entity, dt)
        self:update(RenderSystem.DebugCenterDot, RenderSystem.DebugCenterDot.entity, dt)
    end

    center = (dimensions/2):floor() + offset
end

function RenderSystem.drawTexture(settings, object, ...)
    love.graphics.setShader()
    love.graphics.setColor(1, 1, 1, 1)

    settings = settings or {}

    if settings.shaders then
        for shaderId, params in pairs(settings.shaders) do
            Shader.apply(shaderId, params)

            if Renderables[object] then
                Renderables[object](...)
            end
        end
    else
        if Renderables[object] then
            Renderables[object](...)
        end
    end

    -- love.graphics.setPointSize(10)
    -- love.graphics.points(center.x, center.y)
    -- love.graphics.setShader()
end

function RenderSystem.createQueue()
    if not renderQueue then
       renderQueue, renderQueueCell = wf.queue()
    end
    return renderQueue, renderQueueCell, RenderSystem.drawTexture
end


function RenderSystem:getDimensions()
    return dimensions:copy()
end
function RenderSystem:getScreenCenter()
    return center:copy()
end
function RenderSystem:getScreenOffset()
    return offset:copy()
end

-- local a = vector.new(3, 3)
-- local b = vector.new(1, 2)

-- print("a * b", a * b)
-- print("a * 5", a * 5)
-- print("5 * a", 5 * a)
-- print("a + b", a + b)
-- print("2 * b * 2", 2 * b * 2)

return RenderSystem