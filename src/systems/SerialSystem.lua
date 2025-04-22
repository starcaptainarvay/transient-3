local t3 = require("transient")
local wf = require("workflower")

local SerialSystem = t3.system("Serial")
local PORT = "COM3"
local BAUD = 115200
local COMMAND = string.format('plink -serial %s -sercfg %d,8,n,1 -batch', PORT, BAUD)

local serial, serialPush

function SerialSystem:initSystem()
    serial = io.popen(COMMAND, "r")

    if not serial then
        error("Failed to open serial port: " .. PORT)
    end

    SerialSystem.FIFO, serialPush = wf.queue()
end

function SerialSystem:updateSystem()
    local char

    for i=1, 256 do
        char = serial:read(1)
        if char then
            serialPush(char)
        else break end
    end
end

return SerialSystem