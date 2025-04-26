local t3 = require("transient")
local wf = require ("workflower")

local AttackSystem = t3.system("Attack")
local PeakSystem = t3.system("Peak")
local NoteSystem = t3.system("Note")

local MIDI_START = 21
local MIDI_END = 108

local ATTACK_SUM_THRESHOLD = 4 -- TODO tune this threshold
local AMP_DELTA_SCALING = 2*10^3 -- TODO tune this value

local midi_note_last_amplitudes = {}
local midi_note_attack_sums = {}
local midi_note_attacked = {}
local watchers = {}

local AttackSystemEvents = wf.observable()

function AttackSystem:initSystem()
    for note = MIDI_START, MIDI_END do
        midi_note_last_amplitudes[note] = 0
        midi_note_attack_sums[note] = 0
        midi_note_attacked[note] = false
        local noteEntity = NoteSystem:getMidiNoteEntity(note)
        -- print("noteEntity", noteEntity)
        watchers[note] = t3.addComponent(noteEntity, "Attack", {
            type = "watcher",
            midi = note
        })
    end

    PeakSystem.Events:on("data", function(frequency, amplitude, amplitude_avg, count) 
        local midi = NoteSystem:snapFrequencyToGrid(frequency)
        local noteEntity = NoteSystem:getMidiNoteEntity(midi)

        local ampDelta = amplitude - midi_note_last_amplitudes[midi]
        midi_note_last_amplitudes[midi] = amplitude

        if ampDelta > 0 then 
            midi_note_attack_sums[midi] = midi_note_attack_sums[midi] + 1

            if watchers[midi] then
                watchers[midi].frequency = frequency
                watchers[midi].amplitude = amplitude
                watchers[midi].amplitude_avg = amplitude_avg
                watchers[midi].count = count
            end

            t3.addComponent(noteEntity, "Attack", {
                type = "datapoint",
                midi = midi,
                frequency = frequency,
                amplitude = amplitude,
                amplitude_avg = amplitude_avg,
                count = count,
                death_timestamp = love.timer.getTime() + ampDelta / AMP_DELTA_SCALING, -- convert about 30,000 to 300 ms (0.3s)? but then 1000 --> 10ms...
                timestamp = love.timer.getTime()
            })
    
            -- print("Spun up attack datapoint component at " .. love.timer.getTime() .. " for " .. midi .. " with life time of " .. ampDelta * 10^-5 .. " seconds")
        end
    end)
end

function AttackSystem:update(component, entity)
    if component.type == "watcher" then
        -- print(component.frequency, component.amplitude)
        if midi_note_attack_sums[component.midi] > ATTACK_SUM_THRESHOLD then
            -- print("Watcher at " .. component.midi .. " above threshold with " .. midi_note_attack_sums[component.midi])
            if not midi_note_attacked[component.midi] then
                -- print("Not attacked yet, dispatching event")
                AttackSystemEvents:dispatch("attack", entity, component.midi, component.frequency, component.amplitude, component.amplitude_avg, component.count)
                midi_note_attacked[component.midi] = true
            end     -- else, ignore the fact that we've cleared the threshold because we've already dispatched the event    
        elseif midi_note_attacked[component.midi] then
            -- print("Watcher at " .. component.midi .. " below threshold")
            -- attack has been dispatched and now we've fallen below the threshold
            midi_note_attacked[component.midi] = false
        end
    else -- component.type == "datapoint"
        if love.timer.getTime() > component.death_timestamp then
            -- print("Killing attack component at " .. component.midi)
            t3.removeComponent(entity, component)
            midi_note_attack_sums[component.midi] = midi_note_attack_sums[component.midi] - 1
        end
    end
end

function AttackSystem:on(...)
    return AttackSystemEvents:on(...)
end

function AttackSystem:once(...)
    return AttackSystemEvents:once(...)
end

return AttackSystem