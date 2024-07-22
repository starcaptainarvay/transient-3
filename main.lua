local wf = require("workflower")
local t3 = require("transient")
local socket = require("socket")

local renderQueue, renderQueueCell = wf.queue()
local drawTexture = wf({})

function love.load()
    -- TODO set up transient and workflows
    t3.start()
end

function love.update()
    t3.update() -- Update state of Transient 3 ECS
end

function love.draw()
    for renderedObject in renderQueue:consume() do
        drawTexture(renderedObject)
    end
end