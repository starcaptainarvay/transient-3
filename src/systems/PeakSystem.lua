local t3 = require("transient")
local wf = require("workflower")
local SerialSystem = require("systems.SerialSystem")

local PeakSystem = t3.system("Peak")

-- local vars here
local strbuf = ""
local f_array = {}
local a_array = {}

PeakSystem.Events = wf.observable()

local function avg(array)
    local sum = 0
    for _, val in pairs(array) do
        sum = sum + val
    end
    return sum / #array
end

function PeakSystem:initSystem()
    
end

function PeakSystem:updateSystem()
    for char in SerialSystem.FIFO:consume() do
        if char == "b" then 
            -- clear buffer and arrays
            strbuf = ""
            f_array = {}
            a_array = {}
        elseif char == "f" then
            -- add number to frequency list
            table.insert(f_array, tonumber(strbuf ))
            strbuf = ""
        elseif char == "a" then
            -- add amplitude to amplitude list
            table.insert(a_array, tonumber(strbuf))
            strbuf = ""
        elseif char == "e" then 
            -- dispatch set of peaks
            print("PeakSystem got " .. #f_array .. " from the most recent packet.");
            local amplitude_avg = avg(a_array)
            for i = 1, #f_array do
                PeakSystem.Events:dispatch("data", f_array[i], a_array[i], amplitude_avg, #f_array)
            end
        else -- if char is part of a number 
            -- add char to string buffer
            print("Adding char " .. char .. " to buffer " .. strbuf)
            strbuf = strbuf .. char
        end
    end
end

return PeakSystem