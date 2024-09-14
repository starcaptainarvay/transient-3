local wf = require("workflower")
local t3 = require("transient")
local socket = require("socket")

local renderQueue, renderQueueCell, drawTexture = require("systems.RenderSystem").createQueue()

function love.load()
    
    -- TODO set up transient and workflows
    love.window.setFullscreen(true)
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