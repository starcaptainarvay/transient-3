-- local port = "COM3";
-- local baud = 9600

-- os.execute("powershell $port= new-Object System.IO.Ports.SerialPort "..port..","..baud..",None,8,one;$port.open();$port.close();")

-- local serial = io.open(port,"r")
-- serial:write("0,5,255,2,1000,true")
-- serial:flush()

-- while true do
--     local char = serial:read(1)
--     if char then
--         print(char)
--     end
-- end

-- write example: replace all below "local serial" line with:

-- local serial = io.open(port,"w")
-- serial:write("0,5,255,2,1000,true")
-- serial:flush()
-- serial:close())

-- new example

local PORT, BAUD = "COM3", 115200

local command = string.format('plink -serial %s -sercfg %d,8,n,1 -batch', PORT, BAUD)

local serial = io.popen(command,"r")
if not serial then
    error("Failed to open serial port: " .. PORT)
end

local strbuf = ""
local f_array = {}
local a_array = {}


while true do
    local char = serial:read(1)
    if char then
        -- io.write(char)

        if char == "b" then 
            -- clear buffer and arrays
            print("Got a b -- clearing buffer and arrays")
            strbuf = ""
            f_array = {}
            a_array = {}
        elseif char == "f" then
            -- add number to frequency list
            print("Got a f -- adding to frequency list")
            table.insert(f_array, tonumber(strbuf))
            strbuf = ""
        elseif char == "a" then
            -- add amplitude to amplitude list
            print("Got an a -- adding to amplitude list")
            table.insert(a_array, tonumber(strbuf))
            strbuf = ""
        elseif char == "e" then 
            print("Got an e -- would trigger functionality using new peaks")
            print("Frequency list: " .. table.concat(f_array, ", "))
            print("Amplitude list: " .. table.concat(a_array, ", "))
            -- trigger peak set ready flag
        else -- char is part of a number 
            -- add char to string buffer
            print("Adding char " .. char .. " to buffer " .. strbuf)
            strbuf = strbuf .. char
        end 
    end
end 
