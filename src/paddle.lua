--paddle.lua
Paddle = Object:extend()

function Paddle:new(x, y) --constructor method for new Paddle object
    self.x = x
    self.y = y
    self.width = 5
    self.height = 40
    self.speed = 400
end

function Paddle:yPosCheck()
	if self.y < 0 then
		self.y = 0
	elseif (self.y + self.height) > love.graphics.getHeight() then
		self.y = love.graphics.getHeight() - self.height
	end
end

function Paddle:checkCollision(other)
    --With locals it's common usage to use underscores instead of camelCasing
    local a_left = self.x
    local a_right = self.x + self.width
    local a_top = self.y
    local a_bottom = self.y + self.height

    local b_left = other.x
    local b_right = other.x + other.width
    local b_top = other.y
    local b_bottom = other.y + other.height

    --Directly return this boolean value without using if-statement
    return  a_right > b_left
        and a_left < b_right
        and a_bottom > b_top
        and a_top < b_bottom
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
