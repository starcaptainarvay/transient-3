local t3 = require("transient")
local wf = require("workflower")
local vector = require("src.math.Vector")
local dict = require("transient.util.dict")

local NoteSystem = t3.system("Note")
local FractalExplosion = t3.system("Animation:FractalExplosion")
local RenderSystem = t3.system("Render")

local activeExplosions = {}

local function amplitude_to_gain(amplitude)
    return math.sqrt(math.sqrt(math.sqrt(amplitude / 15000))) - 0.25
end

function FractalExplosion:initSystem()
    NoteSystem:on("fractal-explosion", function(entity, midi, pitch, amplitude, color)
        color = color or { math.random(), math.random(), math.random(), 1 }

        if activeExplosions[midi] then
            activeExplosions[midi].fractal.shaderParams.gain = amplitude_to_gain(amplitude)
            activeExplosions[midi].fractal.shaderParams.pitch = pitch
            return
        end

        activeExplosions[midi] = t3.addComponent(entity, "Animation:FractalExplosion", {
            midi = midi,
            gain = amplitude_to_gain(amplitude),
            pitch = pitch,
            color = color
        })
    end)
end

local function lerp(a, b, t)
    return a + (b - a) * t
end

function FractalExplosion:init(component, entity)
    -- print(component.gain)

    component.created = love.timer.getTime()
    component.expiry = 0.8 + component.gain * 0.2
    component.intensity = component.gain

    component.fractal =  t3.addComponent(entity, "Render", {
        size = vector.new(
            RenderSystem:getDimensions().magnitude,
            RenderSystem:getDimensions().magnitude
        ),
        position = RenderSystem:getDimensions()
            * vector.new(0.5, 0.5)
            * vector.new(
                math.random() - 0.5,
                math.random() - 0.5
            ),
        expiry = component.expiry,
        renderable = "rect",
        shaders = { "outwardFractal" },
        shaderParams = {
            gain = component.gain
        },
        intensity = math.random() * 10,
        argv = { 0, { 0, 0, 0, 0 }, component.color }
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