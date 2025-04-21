local port = "COM3";
local baud = 9600

os.execute("powershell $port= new-Object System.IO.Ports.SerialPort "..port..","..baud..",None,8,one;$port.open();$port.close();")

local serial = io.open(port,"r")
serial:write("0,5,255,2,1000,true")
serial:flush()

while true do
    local char = serial:read(1)
    if char then
        print(char)
    end
end

-- write example: replace all below "local serial" line with:

-- local serial = io.open(port,"w")
-- serial:write("0,5,255,2,1000,true")
-- serial:flush()
-- serial:close())