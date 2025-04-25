local t3 = require("transient")
local wf = require("workflower")

local socket = require("socket")
local host = "127.0.0.1"
local port = 12345
local client, err

local SocketSystem = t3.system("Socket")

local serialPush
SocketSystem.FIFO, serialPush = wf.queue()

function SocketSystem:initSystem()
    client, err = socket.tcp()

    if not client then
        print("Error creating socket:", err)
        return
      end
      
    client:settimeout(0.2) -- Set a timeout for connection attempts (in seconds)
    
    local ok, err = client:connect(host, port)
    if not ok then
      print(string.format("Error connecting to %s:%d: %s", host, port, err))
      return
    end
    
    print(string.format("Connected to %s:%d", host, port))
end

SocketSystem.Events = wf.observable()

function SocketSystem:updateSystem()
  local canread = socket.select({client}, nil, 0)
  while #canread > 0 do
    for _,readyClient in ipairs(canread) do
      local char, err = readyClient:receive(1)
      if not err then
        serialPush(char)
      end
    end
    canread = socket.select({client}, nil, 0)
    -- local data, err = client:receive(1) -- Receive 1 byte at a time

    -- if not data then
    --     if err == "timeout" then
    --       break
    --     end
    --     if err ~= "timeout" then -- ignore timeout error
    --       print("Error receiving data:", err)
    --     end
    -- else
    --     serialPush(data)
    -- end
  end
end

return SocketSystem