local t3 = require("transient")
local wf = require("workflower")

local NoteSystem = t3.system("Note")
local Interpreter = t3.system("MusicInterpreter")

local buffer, queue = wf.queue()
local BUFFER_MAX = 50

local function calculateHarmonyVector(buffer)
    if buffer:size() < 2 then
        return nil -- Not enough data to calculate a vector
    end

    local function calculatePointToPointVector(startNotes, endNotes)
        local vector = {}
        for i = 1, 12 do
            vector[i] = 0
        end

        for _, note in ipairs(startNotes) do
            vector[note + 1] = vector[note + 1] - 1
        end

        for _, note in ipairs(endNotes) do
            vector[note + 1] = vector[note + 1] + 1
        end

        return vector
    end

    local totalVector = {}
    for i = 1, 12 do
        totalVector[i] = 0
    end

    local previousEvent = buffer:get(1)

    for i = 2, buffer:size() do
        local currentEvent = buffer:get(i)

        local startNotes = previousEvent.midi % 12
        local endNotes = currentEvent.midi % 12

        local pointVector = calculatePointToPointVector(startNotes, endNotes)
        for j = 1, 12 do
            totalVector[j] = totalVector[j] + pointVector[j]
        end

        previousEvent = currentEvent
    end

    -- Average the vector over the number of transitions
    local numTransitions = buffer:size() - 1
    for i = 1, 12 do
        totalVector[i] = totalVector[i] / numTransitions
    end

    return totalVector
end

function Interpreter:initSystem()
    NoteSystem:on("note-stream", function(midi, frequency, amplitude, amplitude_avg, count)
        queue({
            midi = midi,
            frequency = frequency,
            amplitude = amplitude,
            amplitude_avg = amplitude_avg,
            count = count
        })

        if buffer:size() > BUFFER_MAX then
            buffer:pop()
        end
    end)
end

function Interpreter:updateSystem()
    local harmonyVector = calculateHarmonyVector(buffer)

    if harmonyVector then
        print("Harmony Vector (Averaged):", table.concat(harmonyVector, ", "))
    else
        print("Not enough data to calculate harmony vector.")
    end
end

return Interpreter