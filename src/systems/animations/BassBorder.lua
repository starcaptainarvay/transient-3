local t3 = require("transient")
local dict = require("transient.util.dict")
local Vector = require("src.math.Vector")

local BassBorderAnimation = t3.system("Animation:BassBorder")
local NoteSystem = t3.system("Note")
local RenderSystem = t3.system("Render") 

local MAX_BORDER_FX_THRESHOLD = 5
local activeBorderEffects = {}

function BassBorderAnimation:initSystem()
    NoteSystem:on("bass-border", function(entity, data)
        -- print("bass-border received")
        if #dict.keys(activeBorderEffects) >= MAX_BORDER_FX_THRESHOLD then return end
        -- print("adding bassborder component...")
        t3.addComponent(entity, "Animation:BassBorder", {
            created = love.timer.getTime(),
            expiry = 0.1
        })
        print("added bassborder component")
    end)
end

function BassBorderAnimation:init(component, entity)

    -- print("inisde bassborder init!")

    activeBorderEffects[component] = true

    -- print("activeBorderEffects[component] = true") -- we get this

    t3.addComponent(entity, "Render", {
        shaders = { "bassBorder" },
        size = RenderSystem:getDimensions(),
        position = Vector.new(0, 0),
        expiry = component.expiry,
        renderable = "rect",
        argv = { false, false, {1.0, 1.0, 1.0, 1.0}}
    })

    -- print("added render component") -- we don't get this 
end

function BassBorderAnimation:update(component, entity)
    -- print("Updating bassborder component")
    if love.timer.getTime() - component.created > component.expiry then
        t3.removeComponent(entity, component)
    end
end

function BassBorderAnimation:destroy(component, entity)
    activeBorderEffects[component] = nil
end

return BassBorderAnimation