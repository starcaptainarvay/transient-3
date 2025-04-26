local t3 = require("transient")
local wf = require("workflower")
local vector = require("src.math.Vector")
local dict = require("transient.util.dict")

local NoteSystem = t3.system("Note")
local MusicInterpreter = t3.system("MusicInterpreter")
local AttackSystem = t3.system("Attack")
local FractalExplosion = t3.system("Animation:FractalExplosion")
local RenderSystem = t3.system("Render")

local activeExplosions = {}

local function amplitude_to_gain(amplitude)
    return math.sqrt(math.sqrt(math.sqrt(amplitude / 15000))) - 0.25
end

function FractalExplosion:initSystem()
    AttackSystem:on("attack", function(entity, midi, pitch, amplitude)
        -- print("attack", entity, midi, pitch, amplitude)
        -- print("attacked")

        -- print(activeExplosions[midi])

        if activeExplosions[midi] then
            activeExplosions[midi].fractal.shaderParams.gain = amplitude_to_gain(amplitude)
            activeExplosions[midi].fractal.shaderParams.pitch = pitch
            return
        end

        -- print("amplitude", amplitude)

        -- print("hello")

        activeExplosions[midi] = t3.addComponent(entity, "Animation:FractalExplosion", {
            midi = midi,
            gain = amplitude_to_gain(amplitude),
            pitch = pitch
        })
    end)
end

local function lerp(a, b, t)
    return a + (b - a) * t
end

function FractalExplosion:init(component, entity)
    -- print(component.gain)

    -- print("init fractal")

    component.created = love.timer.getTime()
    component.expiry = 0.4 + component.gain * 0.2
    component.intensity = component.gain

    component.fractal =  t3.addComponent(entity, "Render", {
        size = RenderSystem:getDimensions(),
        -- vector.new(
        --     RenderSystem:getDimensions().magnitude,
        --     RenderSystem:getDimensions().magnitude
        -- ),
        position = RenderSystem:getDimensions()
            * vector.new(0.7, 0.7)
            * vector.new(
                math.random() - 0.5,
                (math.random() - 0.5)
            ),
        expiry = component.expiry,
        renderable = "fx_rect",
        shaders = { "outwardFractal" },
        shaderParams = {
            gain = component.gain
        },
        intensity = math.random() * 10,
        argv = { 0, { 0, 0, 0, 0 }, MusicInterpreter.colorBucket:get() }
    })
end

function FractalExplosion:update(component, entity)
    component.intensity = lerp(component.intensity, component.gain, 0.1)

    if (love.timer.getTime() - component.created) >= component.expiry then
        t3.removeComponent(entity, component)
    end

    -- component.fractal.shaderParams = dict.merge(component.fractal.shaderParams, {
    --     tick = love.timer.getTime() - component.created
    -- })
end

function FractalExplosion:destroy(component, entity)
    -- if component.monitor then
    --     component.monitor:disconnect()
    -- end
    component.fractal = nil
    activeExplosions[component.midi] = nil
end

return FractalExplosion