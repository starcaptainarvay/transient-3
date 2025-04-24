local wf = require("workflower")
local t3 = require("transient")
local socket = require("socket")
local vector = require("src.math.vector")

local inputSystem = require("systems.InputSystem")
local renderQueue, renderQueueCell, drawTexture = require("systems.RenderSystem").createQueue()

local serialSystem = require("systems.SerialSystem")
local PeakSystem = require("systems.PeakSystem")

function love.load()
    -- TODO set up transient and workflows
    love.window.setFullscreen(true)
    t3.start()

    inputSystem:on("down", function(key, scanCode, isRepeat)
        if key ~= "q" then return end
        local quitting = true

        inputSystem:once("down", function(key)
            if key == "escape" then quitting = false end
        end)

        inputSystem:once("up", function(key)
            if key == "q" and quitting then
                love.event.quit()
            end
        end)
    end)
end



function love.update()
    -- print('drawing rect:')
    -- print('drew')
    t3.update() -- Update state of Transient 3 ECS

    -- for object in serialSystem.FIFO:consume() do
    --     io.write(object)
    -- end
end

function love.draw()
    love.graphics.clear(0, 0, 0, 1)

    for renderedObject in renderQueue:consume() do
        drawTexture(unpack(renderedObject))
    end
end