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

    gradient:send("center", {2, 2})
    -- gradient:send("strength", 2)                                                     -- Center of the gradient (normalized coordinates)
    -- gradient:send("resolution", { love.graphics.getWidth(), love.graphics.getHeight() })    -- Screen resolution
    gradient:send("color2", {0.0, 0, 0.0})                                                  -- Color at the center (red)
    gradient:send("color1", {1.0, 0.0, 0.0})                                                -- Color at the edges (blue)
end

function love.update()
    t3.update() -- Update state of Transient 3 ECS
end

function love.draw()
    love.graphics.setShader(gradient)

    local x_offset = 75/love.graphics.getWidth()
    local y_offset = 75/love.graphics.getHeight()

    -- print(x_offset, y_offset)

    gradient:send("center", {75, 75})
    gradient:send("size", {70, 70})

    love.graphics.circle("fill", 75, 75, 35)
    -- love.graphics.rectangle("fill", 40, 40, 70, 70)

    love.graphics.setShader()

    for renderedObject in renderQueue:consume() do
        -- drawTexture(renderedObject)
    end
end