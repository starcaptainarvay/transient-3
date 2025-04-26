local wf = require("workflower")
local t3 = require("transient")
local socket = require("socket")
local vector = require("src.math.vector")

local inputSystem = require("systems.InputSystem")
local renderQueue, renderQueueCell, drawTexture = require("systems.RenderSystem").createQueue()

local socketSystem = require("systems.SocketSystem")
local PeakSystem = require("systems.PeakSystem")
local NoteSystem = require("systems.NoteSystem")
local AttackSystem = require("systems.AttackSystem")
local MusicInterpreter = require("systems.MusicInterpreter")

local ParticleSystem = require("systems.animations.ParticleSystem")
local FireSystem = require("systems.animations.FireSystem")
local FractalExplosion = require("systems.animations.FractalExplosion")
local EmissionManager = require("systems.animations.EmissionManager")

local screen, screenData
local texture = {}
local particleSystem = {}

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

function love.update(dt)
    t3.update(dt) -- Update state of Transient 3 ECS

    -- print(dt)
end

function love.draw()
    love.graphics.clear(0, 0, 0, 1)

    for renderedObject in renderQueue:consume() do
        drawTexture(unpack(renderedObject))
    end
end