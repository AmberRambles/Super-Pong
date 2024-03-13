--ball.lua
Ball = Object:extend()

function Ball:new(x,y)
    self.x = x
    self.y = y
    self.speed = 100
    self.radius = 5
    self.xMod = 0.5
    self.yMod = 0.5
end

function Ball:yBoundCheck()
	local yBound = love.graphics.getHeight()
	if (self.y - self.radius <= 0) then
		--bounce() --from top bound
		print("Bounce top")
	elseif (self.y + self.radius >= yBound) then
		--bounce() --from bottom bound
		print("Bounce bottom")
	end
end

function Ball:xBoundCheck()
	local xBound = love.graphics.getWidth()
	if (self.x - self.radius) <= 0 then
		--point() --from left bound
		print("Point CPU")
	elseif (self.x + self.radius >= xBound) then
		--point() --from right bound
		print("Point Player")
	end
end

function Ball:update(dt)
	self.x = self.x + (self.speed * self.xMod * dt)
	self.y = self.y + (self.speed * self.yMod * dt)
	self:xBoundCheck()
	self:yBoundCheck()
end

function Ball:draw()
    love.graphics.circle("fill", self.x, self.y, self.radius)
end
