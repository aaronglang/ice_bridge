require 'socket' 
--require 'ex'




DiscoverMessage = 'Discovery: Who is out there?'

NETWORKS =
{
   '255.255.255.255', 
--     '192.168.200.255',
--     '192.168.11.255',
--     '192.168.250.1',
--     '10.10.10.255',
--     '10.0.0.255',
--     '192.168.7.255',
}



for I,J in ipairs(NETWORKS) do

  Num_Timeouts = 0
  udp = socket.udp() 
  assert(udp:setoption('broadcast',true)) 
 -- assert(udp:setoption('dontroute',true)) 
  assert(udp:setsockname('0.0.0.0',30303)) 
  assert(udp:settimeout (1))
  assert(udp:sendto(DiscoverMessage, J, 30303)) 

  while Num_Timeouts < 2 do

    message,host = udp:receivefrom(1024)


    if message == nil then
      Num_Timeouts = Num_Timeouts + 1
    else
      if message ~= DiscoverMessage then
          -- print(message)
	  -- io.flush()
          A={}
          for w in string.gmatch(message,".-%c%c") do
              A[#A+1] = string.sub(w,1,-3)
          end

          if A[1] == nil then A[1] = "nil" end
          if A[2] == nil then A[2] = "nil" end
          print(string.format('%20s     %15s      %20s', host, A[1], A[2]))
	  io.flush()
      end
    end

    -- os.sleep(500,1000)
    os.execute("sleep .5")

  end

  udp:close() 

end

-- os.execute( 'pause' )

