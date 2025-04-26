local t3 = require("transient")
local wf = require("workflower")

local NoteSystem = t3.system("Note")
local PeakSystem = t3.system("Peak")

-- Define the range of MIDI notes (e.g., 21 to 108 for a full piano keyboard)
local MIDI_START = 21
local MIDI_END = 108

local MIDI_NOTE_QUEUES = {}

local midi_note_entities = {}

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

local NoteSystemEvents = wf.observable()

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

        midi_note_entities[note] = entity

    end

    PeakSystem.Events:on("data", function(frequency, amplitude, amplitude_avg, count)
        local pitch = NoteSystem:snapFrequencyToGrid(frequency)

        local queueIncomingEvent = MIDI_NOTE_QUEUES[pitch]
        if queueIncomingEvent then
            queueIncomingEvent({ frequency = frequency, amplitude = amplitude, amplitude_avg = amplitude_avg, count = count })
        end

        if count >= 3 then
            -- print("Will effecting...")
            NoteSystemEvents:dispatch("willEffect", {
                count = count,
                amplitude_avg = amplitude_avg,
                frequency = frequency
            })
        end
    end)
end


function NoteSystem:update(component, entity)
    for event in component.incomingEvents:consume() do
        local pitch, amplitude, amplitude_avg, count = event.frequency, event.amplitude, event.amplitude_avg, event.count
        -- print("Got pitch: " .. pitch .. " and amplitude " .. amplitude .. " -- midi = " .. component.midi .. " count = " .. count)

        print(event.amplitude_avg)

        if component.midi < 38 then
            NoteSystemEvents:dispatch("bass-border", entity, {
                type = "note",
                midi = component.midi,
                pitch = pitch,
                amplitude = amplitude
            })
        end

        if amplitude > 6000 then
            NoteSystemEvents:dispatch(
                "fractal-explosion", entity,
                component.midi, pitch, amplitude
            )
        end

        NoteSystemEvents:dispatch("will-effect-amplitude", event.amplitude_avg)
    end
end

function NoteSystem:on(...)
    return NoteSystemEvents:on(...)
end

function NoteSystem:once(...)
    return NoteSystemEvents:once(...)
end

function NoteSystem:getMidiNoteEntity(midiNote)
    -- print("Called getMidiNoteEntity with " .. midiNote .. ". returning " .. tostring(midi_note_entities[midiNote]))
    if not midi_note_entities[midiNote] then
        print(midiNote, "not found, creating new entity")
        midi_note_entities[midiNote] = t3.entity()
    end
    return midi_note_entities[midiNote]
end

return NoteSystem