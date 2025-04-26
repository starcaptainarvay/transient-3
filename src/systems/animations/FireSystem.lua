local t3 = require("transient")
local wf = require("workflower")

local Render = t3.system("Render")
local NoteSystem = t3.system("Note")
local vector = require("src.math.Vector")
local FireSystem = t3.system("GroupFire")

local queue, pushToQueue = wf.queue()
local SCALE = {
    ADD = 1,
    REMOVE = 1,
}

local function vec_array(vector)
    return {
        vector.x, vector.y
    }
end

function FireSystem:initSystem()
    local entity = t3.entity()

    t3.addComponent(entity, "GroupFire", {
        renderComp = t3.addComponent(entity, "Render", {
            size = Render:getDimensions(),
            position = vector.new(0, 0),
            renderable = "fx_rect",
            shaders = { "fire" },
            intensity = 0,
            shaderParams = {
                dimensions = vec_array(Render:getDimensions())
            },
            argv = {false, false, {0, 0, 0, 0}}
        })
    })

    NoteSystem:on("imagine-effect-fire", function(count)
        for i=1, count * SCALE.ADD do
            pushToQueue({})
        end
    end)
end

local function getIntensity()
    local intensity = 0

    if queue:size() > 0 then
        intensity = math.min(queue:size() / (1000 * SCALE.ADD), 1)
    end

    return intensity
end

function FireSystem:update(component, entity)
    local comp = component.renderComp

    comp.shaderParams.dimensions = vec_array(Render:getDimensions())
    comp.shaderParams.size = Render:getDimensions()

    local intensity = getIntensity()
    comp.intensity = intensity

    comp.argv[3] = {
        intensity, intensity, intensity, intensity
    }
end

function FireSystem:updateSystem()
    -- print(queue:size())
    for i=1, SCALE.REMOVE do
        if queue:size() > 0 then
            queue:pop()
        else return end
    end
end

return FireSystem