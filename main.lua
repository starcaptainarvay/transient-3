local wf = require("workflower")
local t3 = require("transient")
local socket = require("socket")
local vector = require("src.math.vector")

local renderQueue, renderQueueCell, drawTexture = require("systems.RenderSystem").createQueue()

local dimensions, center, offset

function love.load()
    -- TODO set up transient and workflows
    love.window.setFullscreen(true)
    t3.start()
    dimensions = vector.new(1920, 1080)
    center = (dimensions/2):floor()

    local width, height = love.window.getMode()
    offset = ((vector.new(width, height) - dimensions)/2):floor()
end

local KEY_VECS = {
    up = vector.new(0, 1),
    down = vector.new(0, -1),
    right = vector.new(1, 0),
    left = vector.new(-1, 0)
}

local ADJUST_SCALE = 1

function love.update()
    love.graphics.setColor(0, 1, 0, 1)

    for key, value in pairs(KEY_VECS) do
        if love.keyboard.isDown(key) then
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
            love.graphics.setColor(1, .7, .2, 1)
            print(dimensions, center + offset)
        end
    end

    -- print('drawing rect:')
    -- print('drew')
    t3.update() -- Update state of Transient 3 ECS
end

function love.draw()
    love.graphics.setLineWidth(10)
    love.graphics.rectangle("line", offset.x, offset.y, dimensions.x, dimensions.y)

    for renderedObject in renderQueue:consume() do
        drawTexture(renderedObject)
    end
end