--paddle.lua
Paddle = Object:extend()

function Paddle:new(x, y) --constructor method for new Paddle object
    self.x = x
    self.y = y
    self.width = 5
    self.height = 40
    self.speed = 200
end

function Paddle:yPosCheck()
	if self.y < 0 then
		self.y = 0
	elseif (self.y + self.height) > love.graphics.getHeight() then
		self.y = love.graphics.getHeight() - self.height
	end
end

function Paddle:userUpdate(dt)		 --sets rules for player motion
	if love.keyboard.isDown("up") then
		self.y = self.y - (self.speed * dt)
	elseif love.keyboard.isDown("down") then
		self.y = self.y + (self.speed * dt)
	end
	self:yPosCheck()
end

function Paddle:computerUpdate(dt)
	self:yPosCheck()
    --self.y = self.y + (self.speed * dt)
end

function Paddle:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
