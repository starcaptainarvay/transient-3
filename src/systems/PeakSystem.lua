local t3 = require("transient")
local wf = require("workflower")
local SocketSystem = require("systems.SocketSystem")

local PeakSystem = t3.system("Peak")
local InputSystem = t3.system("Input")

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
    InputSystem:on("down", function(key, scancode, isrepeat)
        if key == "space" then
            local f2, a2 = {}, {}
            -- generate random frequency and amplitude arrays
            for i = 1, math.random(1, 5) do
                local fund = math.random(230, 6000)
                local amp = math.random(1, 30000)
                table.insert(f2, fund) -- random frequency between 20Hz and 20kHz
                table.insert(f2, fund * 1.5) -- fifth
                table.insert(f2, fund * 2) -- octave
                table.insert(f2, fund * 8/3) -- tenth
                -- 
                table.insert(a2, amp) -- random amplitude between 1 and 100
                table.insert(a2, amp * .9) -- random amplitude between 1 and 100
                table.insert(a2, amp * .7) -- random amplitude between 1 and 100
                table.insert(a2, amp * .5) -- random amplitude between 1 and 100
            end

            local amplitude_avg = avg(a2)

            for i = 1, #f2 do
                PeakSystem.Events:dispatch("data", f2[i], a2[i], amplitude_avg, #f2)
            end
        end
    end)
end

function PeakSystem:updateSystem()
    for char in SocketSystem.FIFO:consume() do
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
            -- print("PeakSystem got " .. #f_array .. " from the most recent packet.");
            local amplitude_avg = avg(a_array)
            for i = 1, #f_array do
                PeakSystem.Events:dispatch("data", f_array[i], a_array[i], amplitude_avg, #f_array)
            end
        else -- if char is part of a number 
            -- add char to string buffer
            strbuf = strbuf .. char
        end
    end
end

return PeakSystem