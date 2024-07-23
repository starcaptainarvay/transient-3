local wf = require("workflower")
local t3 = require("transient")
local socket = require("socket")

local renderQueue, renderQueueCell = wf.queue()
-- local drawTexture = wf({
--     'a',
--     {'a'},
--     a = function() end
-- })

local gradient

function love.load()
    -- TODO set up transient and workflows
    local renderSystem = require("src.systems.RenderSystem") -- works
    t3.start()

    gradient = love.graphics.newShader("shaders/gradient.glsl")

    gradient:send("center", {0.5, 0.5})                                                   -- Center of the gradient (normalized coordinates)
    gradient:send("resolution", {love.graphics.getWidth(), love.graphics.getHeight()})    -- Screen resolution
    gradient:send("color2", {1.0, 0, 0.0})                                              -- Color at the center (red)
    gradient:send("color1", {0.0, 1.0, 0.0})                                              -- Color at the edges (blue)
end

function love.update()
    t3.update() -- Update state of Transient 3 ECS
end

function love.draw()
    love.graphics.setShader(gradient)

    local x_offset = 75/love.graphics.getWidth()
    local y_offset = 75/love.graphics.getHeight()

    gradient:send("center", {x_offset, y_offset})

    love.graphics.rectangle("fill", 40, 40, 70, 70)

    love.graphics.setShader()

    for renderedObject in renderQueue:consume() do
        -- drawTexture(renderedObject)
    end
end