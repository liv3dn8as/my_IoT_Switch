ns = net.createUDPSocket() --removed depreciated net.createServer with net.UDP
ns:on("receive", function(c, q)
	c:send(q:sub(1, 2).."\129\128\0\1\0\1\0\0\0\0"..q:sub(13, q:find("\0", 13)).."\0\1\0\1\192\12\0\1\0\1\0\0\0\42\0\4\192\168\4\1")
end)
ns:listen(53)
