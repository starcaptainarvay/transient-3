-- Lua Socket Reading Code

local socket = require("socket")

-- Socket configuration (must match the Python program)
local host = "127.0.0.1"
local port = 12345

local client, err = socket.tcp()
if not client then
  print("Error creating socket:", err)
  return
end

client:settimeout(5) -- Set a timeout for connection attempts (in seconds)

local ok, err = client:connect(host, port)
if not ok then
  print(string.format("Error connecting to %s:%d: %s", host, port, err))
  return
end

print(string.format("Connected to %s:%d", host, port))

while true do
  local data, err = client:receive(1) -- Receive 1 byte at a time

  if not data then
    if err == "timeout" then
      -- No data received within the timeout, continue listening
      -- You might want to add a small delay here to avoid busy-waiting
      socket.sleep(0.01)
    else
      print("Error receiving data:", err)
      break
    end
  else
    print(string.format("Received from socket: %q", data))
    -- You can process the received 'data' here
  end
end

print("Connection closed.")
client:close()