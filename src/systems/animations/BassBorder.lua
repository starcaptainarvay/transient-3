local t3 = require("transient")
local dict = require("transient.util.dict")
local Vector = require("src.math.Vector")

local BassBorderAnimation = t3.system("Animation:BassBorder")
local NoteSystem = t3.system("Note")
local RenderSystem = t3.system("Render") 

local MAX_BORDER_FX_THRESHOLD = 25
local activeBorderEffects = {}

function BassBorderAnimation:initSystem()
    NoteSystem:on("bass-border", function(entity, data)
        if #dict.keys(activeBorderEffects) >= MAX_BORDER_FX_THRESHOLD then return end

        t3.addComponent(entity, "Animation:BassBorder", {
            created = love.timer.getTime(),
            expiry = 1
        })
    end)
end

function BassBorderAnimation:init(component, entity)
    activeBorderEffects[component] = true

    t3.addComponent(entity, "Render", {
        shaders = { "bassBorder" },
        size = RenderSystem:getDimensions(),
        position = Vector.new(),
        expiry = component.expiry,
        renderable = "rect",
        argv = { 10, nil, {1.0, 1.0, 1.0, 1.0} }
    })

end

function BassBorderAnimation:update(component, entity)
    if love.timer.getTime() - component.created > component.expiry then
        t3.removeComponent(entity, component)
    end
end

function BassBorderAnimation:destroy(component, entity)
    activeBorderEffects[component] = nil
end

return BassBorderAnimation