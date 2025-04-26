local t3 = require("transient")
local wf = require("workflower")

local dict = require("transient.util.dict")

local NoteSystem = t3.system("Note")
local Interpreter = t3.system("MusicInterpreter")

local buffer, queue = wf.queue()
local colorBucket, setGlobalColor = wf.bucket(nil, {1,1,1,1})
local BUFFER_MAX = 60

local function sortAndGroupByTimestamp(array, threshold, ...)
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

    return nil, grouped, ...
end

local function calculateHarmonyVectorFromGroups(groups, ...)
    local totalVector = {}
    for i = 1, 12 do
        totalVector[i] = 0
    end

    for _, group in ipairs(groups) do
        local groupVector = {}
        for i = 1, 12 do
            groupVector[i] = 0
        end

        for _, event in ipairs(group) do
            local pitchClass = event.midi % 12
            groupVector[pitchClass + 1] = groupVector[pitchClass + 1] + 1
        end

        for i = 1, 12 do
            totalVector[i] = totalVector[i] + groupVector[i]
        end
    end

    -- Normalize the vector by the number of groups
    local numGroups = #groups
    for i = 1, 12 do
        totalVector[i] = totalVector[i] / numGroups
    end

    return nil, totalVector, ...
end

-- Helper function to convert HSV to RGB
local function hsvToRgb(h, s, v)
    local r, g, b

    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)

    i = i % 6

    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end

    return {r, g, b}
end

local function mapHarmonyVectorToColor(harmonyVector, ...)
    -- Normalize the vector to get a weighted average of pitch classes
    local totalWeight = 0
    for _, weight in ipairs(harmonyVector) do
        totalWeight = totalWeight + weight
    end

    if totalWeight == 0 then
        return {0, 0, 0, 1} -- Return black if the vector is empty
    end

    local normalizedVector = {}
    for i, weight in ipairs(harmonyVector) do
        normalizedVector[i] = weight / totalWeight
    end

    -- Map the normalized vector to a color
    local red = 0
    local green = 0
    local blue = 0

    for i, weight in ipairs(normalizedVector) do
        local hue = i / 12 -- Map pitch class to a hue (0 to 1)
        local color = hsvToRgb(hue, 1, weight) -- Convert hue to RGB with full saturation and brightness
        red = red + color[1]
        green = green + color[2]
        blue = blue + color[3]
    end

    -- Clamp the color values to [0, 1]
    red = math.min(1, red)
    green = math.min(1, green)
    blue = math.min(1, blue)

    return nil, {red, green, blue, 1}, ... -- Return the final color with full alpha
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

local calculateHarmonyColor = wf({
    'sortAndGroupByTimestamp',
    {
        'sortAndGroupByTimestamp',
        'calculateHarmonyVectorFromGroups',
        'mapHarmonyVectorToColor',
        'setGlobalColor'
    },
    sortAndGroupByTimestamp = sortAndGroupByTimestamp,
    calculateHarmonyVectorFromGroups = calculateHarmonyVectorFromGroups,
    mapHarmonyVectorToColor = mapHarmonyVectorToColor,
    setGlobalColor = setGlobalColor
})

function Interpreter:updateSystem()
    -- local harmonyColor = 
    calculateHarmonyColor(buffer:array(), 0.1)

    -- if harmonyColor then
    --     print("Harmony Vector (From Groups):", table.concat(harmonyColor, ", "))
    -- else
    --     print("Not enough data to calculate harmony vector.")
    -- end
end

return Interpreter