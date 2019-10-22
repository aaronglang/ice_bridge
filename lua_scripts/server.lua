local socket = require("socket")

--{{Options
---The port number for the HTTP server. Default is 80
PORT=3434
---The parameter backlog specifies the number of client connections
-- that can be queued waiting for service. If the queue is full and
-- another client attempts connection, the connection is refused.
BACKLOG=5
--}}Options

-- create a TCP socket and bind it to the local host, at any port
server=assert(socket.tcp())
assert(server:bind("127.0.0.1", PORT))
server:listen(BACKLOG)

-- Print IP and port
local ip, port = server:getsockname()
print("Listening on IP="..ip..", PORT="..port.."...")

-- loop forever waiting for clients
while 1 do
	-- wait for a connection from any client
	local client,err = server:accept()

	if client then
		local line, err = client:receive()
		-- if there was no error, send it back to the client
		if not err then
      print("received request")
			client:send(line .. "testing")
    else 
      print("error")
		end

	else
		print("Error happened while getting the connection.nError: "..err)
	end

	-- done with client, close the object
	client:close()
	print("Terminated")
end
