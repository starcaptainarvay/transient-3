local t3 = require("transient")
local wf = require("workflower")

local NoteSystem = t3.system("Note")
local PeakSystem = t3.system("systems.PeakSystem")

-- Define the range of MIDI notes (e.g., 21 to 108 for a full piano keyboard)
local MIDI_START = 21
local MIDI_END = 108

local MIDI_NOTE_QUEUES = {}

-- Helper function to calculate the frequency of a MIDI note
local function midiToFrequency(note)
    return 440 * (2 ^ ((note - 69) / 12))
end

-- Helper function to snap a frequency to the nearest MIDI note using a step function
function NoteSystem:snapFrequencyToGrid(frequency)
    local note = math.floor(69 + 12 * math.log(frequency / 440) / math.log(2) + 0.5) -- Round to nearest MIDI note

    if note < MIDI_START then
        note = MIDI_START
    elseif note > MIDI_END then
        note = MIDI_END
    end

    return note
end

function NoteSystem:initSystem()
    -- Create an entity for each MIDI note
    for note = MIDI_START, MIDI_END do
        local frequency = midiToFrequency(note)
        local incomingEventQueue, queueIncomingEvent = wf.queue()

        local entity = t3.entity()
        t3.addComponent(entity, "Note", {
            midi = note,
            pitch = frequency,
            active = false,
            incomingEvents = incomingEventQueue,
        })

        MIDI_NOTE_QUEUES[note] = queueIncomingEvent
    end

    PeakSystem.Events:on("data", function(frequency, amplitude, amplitude_avg, count)
        local pitch = NoteSystem:snapFrequencyToGrid(frequency)

        local queueIncomingEvent = MIDI_NOTE_QUEUES[pitch]
        if queueIncomingEvent then
            queueIncomingEvent({ frequency = frequency, amplitude = amplitude, amplitude_avg = amplitude_avg, count = count })
        end
    end)
end

function NoteSystem:update(component, entity)
    for event in component.incomingEvents:consume() do
        local pitch, amplitude, amplitude_avg, count = event.frequency, event.amplitude, event.amplitude_avg, event.count

        -- TODO handle event
        
    end
end

return NoteSystem