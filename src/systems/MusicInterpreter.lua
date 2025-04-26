local t3 = require("transient")
local wf = require("workflower")

local dict = require("transient.util.dict")

local NoteSystem = t3.system("Note")
local Interpreter = t3.system("MusicInterpreter")

local buffer, queue = wf.queue()
local BUFFER_MAX = 60

local function sortAndGroupByTimestamp(array, threshold)
    table.sort(array, function(a, b) return a.stamp < b.stamp end)

    local grouped = {}
    local currentGroup = {}

    for i, entry in ipairs(array) do
        if #currentGroup == 0 then
            table.insert(currentGroup, entry)
        else
            local lastEntry = currentGroup[#currentGroup]
            -- print(entry.stamp, lastEntry.stamp)
            if math.abs(entry.stamp - lastEntry.stamp) <= threshold then
                table.insert(currentGroup, entry)
            else
                table.insert(grouped, currentGroup)
                currentGroup = {entry}
            end
        end
    end

    if #currentGroup > 0 then
        table.insert(grouped, currentGroup)
    end

    return grouped
end

local function calculateHarmonyVector(buffer)
    local buf = buffer:array()
    local groups = sortAndGroupByTimestamp(buf, 0.3)

    print(#groups)

    for i=1, #groups do
        print(#groups[i])
    end
end

function Interpreter:initSystem()
    NoteSystem:on("note-stream", function(timestamp, midi, frequency, amplitude, amplitude_avg, count)
        queue({
            stamp = timestamp,
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