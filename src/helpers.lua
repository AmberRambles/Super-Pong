--helpers.lua

function randomStartup()
	math.randomseed(os.time())
	for i = 1,5 do
		math.random()
	end
end

random = math.random

function printSlow(str, seconds)
	--sets default duration to 2 seconds if not specified
	if(seconds == nil) then
		seconds = 2
	end

	--Sleep for the specified duration (this is OS independent and safe)
	local startTime = os.time()
    local endTime = startTime + seconds
    while(endTime>=os.time())
        do startTime = startTime + 1
	end

	--print string
	print(str)
end

function distanceBetweenPoints(x1, y1, x2, y2)
	local dx = x2 - x1
    	local dy = y2 - y1
    	return math.sqrt((dx * dx) + (dy * dy))
end
