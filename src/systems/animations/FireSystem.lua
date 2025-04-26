local t3 = require("transient")
local wf = require("workflower")

local Render = t3.system("Render")
local NoteSystem = t3.system("Note")
local vector = require("src.math.Vector")
local FireSystem = t3.system("GroupFire")

local queue, pushToQueue = wf.queue()
local SCALE = 30

function FireSystem:initSystem()
    local entity = t3.entity()

    t3.addComponent(entity, "GroupFire", {
        renderComp = t3.addComponent(entity, "Render", {
            size = Render:getDimensions(),
            position = vector.new(0, 0),
            renderable = "fx_rect",
            shaders = { "fire" },
            shaderParams = {
                dimensions = Render:getDimensions()
            },
            argv = {false, false, {0, 0, 0, 0}}
        })
    })

    NoteSystem:on("imagine-effect-fire", function(count)
        for i=1, count * SCALE do
            pushToQueue({})
        end
    end)
end

function FireSystem:update(component, entity)
    local comp = component.renderComp

    comp.shaderParams.dimensions = { Render:getDimensions().x, Render:getDimensions().y }
    comp.shaderParams.size = Render:getDimensions()
    comp.shaderParams.intensity = (queue:size()/3) ^ 2

    local intensity = math.min(queue:size() / (10 * SCALE), 1)
    comp.argv[3] = {
        intensity, intensity, intensity, intensity
    }
end

function FireSystem:updateSystem()
    if queue:size() > 0 then
        queue:pop()
    end
end

return FireSystem