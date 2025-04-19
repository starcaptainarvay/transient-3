local wf = require("workflower")
local t3 = require("transient")
local socket = require("socket")
local vector = require("src.math.vector")

local inputSystem = require("systems.InputSystem")
local renderQueue, renderQueueCell, drawTexture = require("systems.RenderSystem").createQueue()

function love.load()
    -- TODO set up transient and workflows
    love.window.setFullscreen(true)
    t3.start()
end



function love.update()
    -- print('drawing rect:')
    -- print('drew')
    t3.update() -- Update state of Transient 3 ECS
end

function love.draw()
    for renderedObject in renderQueue:consume() do
        drawTexture(unpack(renderedObject))
    end
end