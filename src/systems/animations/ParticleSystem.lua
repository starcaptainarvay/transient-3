local t3 = require("transient")
local wf = require("workflower")
local vector = require("src.math.Vector")
local dict = require("transient.util.dict")

local ROOT_PATH = "assets/textures/%s"
local NoteSystem = t3.system("Note")
local ParticleSystem = t3.system("Particle")
local RenderSystem = t3.system("Render")

local Textures = {}

function ParticleSystem.loadTexture(texturePath)
    if Textures[texturePath] then
        return Textures[texturePath]
    end

    Textures[texturePath] = love.graphics.newImage(ROOT_PATH:format(texturePath))
    return Textures[texturePath]
end

function ParticleSystem:initSystem()
    local ParticleSystemLocalEntity = t3.entity()

    local textures = dict.flat(dict.echo({
        "particle_texture_1.png",
        "particle_texture_2.png",
        "particle_texture_3.png",
        "particle_texture_4.png",
        "particle_texture_5.png"
    }, 30))

    for _, particleSystemComponent in pairs(dict.map(textures, function(path)
        return t3.addComponent(ParticleSystemLocalEntity, "Particle", {
            texture = path,
            max = 100
        })
    end)) do
        t3.addComponent(ParticleSystemLocalEntity, "Render", {
            size = vector.new(0, 0),
            position = vector.new(
                RenderSystem:getDimensions().x * 0.75 * (math.random() - 0.5),
                RenderSystem:getDimensions().y * 0.75 * (math.random() - 0.5)
            ),
            renderable = "particle",
            shaders = { "distortion" },
            intensity = math.random() * 10,
            argv = { particleSystemComponent.drawable }
        })
    end
end

function ParticleSystem:init(component, entity)
    local ps = love.graphics.newParticleSystem(self.loadTexture(component.texture), component.max)

    ps:setParticleLifetime(0.1, 0.3)
    ps:setEmissionRate(200) -- Emit 200 particles per second for a sharp impulse
    ps:setSizes(0.5, 1, 2, 4, 8, 6, 3, 0.5)
    ps:setSizeVariation(1) -- Moderate size variation
    ps:setLinearAcceleration(-50, -50, 50, 50) -- Random acceleration in all directions
    ps:setColors(
        1, 1, 1, 1,  -- Start fully opaque white
        1, 0.5, 0.5, 0.8,  -- Transition to a softer red
        0.5, 0.5, 1, 0.5,  -- Transition to a soft blue
        0, 0, 0, 0  -- Fade to transparent
    )
    ps:setSpread(math.pi * 2)
    ps:setSpeed(100, 2000)
    ps:start()

    component.drawable = ps
end

function ParticleSystem:update(component, entity, dt)
    component.drawable:update(dt)
end

return ParticleSystem