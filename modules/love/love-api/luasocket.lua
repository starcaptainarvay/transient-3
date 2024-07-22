---@meta
---@module 'socket'

--- Provides a TCP/UDP socket interface.
---@class socket
socket = {}

--- Creates and returns a TCP object.
---@return socket.tcp The TCP object.
function socket.tcp() end

--- Creates and returns a UDP object.
---@return socket.udp The UDP object.
function socket.udp() end

--- Selects a set of sockets ready for reading or writing.
---@param recvt table A table with sockets to test for reading.
---@param sendt table A table with sockets to test for writing.
---@param timeout number The maximum amount of time to wait, in seconds.
---@return table recvt A table with sockets ready for reading.
---@return table sendt A table with sockets ready for writing.
function socket.select(recvt, sendt, timeout) end

--- Converts an IP address to its binary representation.
---@param ip string The IP address.
---@return string binary The binary representation of the IP address.
function socket.dns.toip(ip) end

--- Converts a binary IP address to its string representation.
---@param binary string The binary representation of the IP address.
---@return string ip The IP address.
function socket.dns.tohostname(binary) end

---@class socket.tcp
local tcp = {}

--- Binds the TCP object to an address and port.
---@param address string The address to bind to.
---@param port number The port to bind to.
---@return boolean success True if successful, false otherwise.
function tcp:bind(address, port) end

--- Connects the TCP object to an address and port.
---@param address string The address to connect to.
---@param port number The port to connect to.
---@return boolean success True if successful, false otherwise.
function tcp:connect(address, port) end

--- Closes the TCP object.
---@return boolean success True if successful, false otherwise.
function tcp:close() end

--- Sends data over the TCP connection.
---@param data string The data to send.
---@return number bytes The number of bytes sent.
---@return string err The error message, if any.
function tcp:send(data) end

--- Receives data from the TCP connection.
---@param pattern string The pattern to use for reading.
---@return string data The received data.
---@return string err The error message, if any.
function tcp:receive(pattern) end

--- Sets the timeout for the TCP object.
---@param timeout number The timeout in seconds.
---@return boolean success True if successful, false otherwise.
function tcp:settimeout(timeout) end

--- Sets the TCP object to non-blocking mode.
---@return boolean success True if successful, false otherwise.
function tcp:settimeout() end

--- Listens for incoming connections on the TCP object.
---@param backlog number The maximum number of connections to accept.
---@return boolean success True if successful, false otherwise.
function tcp:listen(backlog) end

--- Accepts an incoming connection on the TCP object.
---@return socket.tcp client The client socket.
---@return string err The error message, if any.
function tcp:accept() end

---@class socket.udp
local udp = {}

--- Sets the peer address and port for the UDP object.
---@param address string The address to set.
---@param port number The port to set.
---@return boolean success True if successful, false otherwise.
function udp:setpeername(address, port) end

--- Sets the local address and port for the UDP object.
---@param address string The address to set.
---@param port number The port to set.
---@return boolean success True if successful, false otherwise.
function udp:setsockname(address, port) end

--- Sends data over the UDP connection.
---@param data string The data to send.
---@param address string The address to send to.
---@param port number The port to send to.
---@return number bytes The number of bytes sent.
---@return string err The error message, if any.
function udp:sendto(data, address, port) end

--- Receives data from the UDP connection.
---@param size number The maximum number of bytes to receive.
---@return string data The received data.
---@return string ip The sender's IP address.
---@return number port The sender's port.
---@return string err The error message, if any.
function udp:receivefrom(size) end

--- Sets the timeout for the UDP object.
---@param timeout number The timeout in seconds.
---@return boolean success True if successful, false otherwise.
function udp:settimeout(timeout) end

--- Closes the UDP object.
---@return boolean success True if successful, false otherwise.
function udp:close() end

---@class socket.dns
local dns = {}

--- Gets the IP address of a host.
---@param hostname string The hostname.
---@return string ip The IP address.
function dns.toip(hostname) end

--- Gets the hostname of an IP address.
---@param ip string The IP address.
---@return string hostname The hostname.
function dns.tohostname(ip) end

return socket
