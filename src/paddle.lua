--paddle.lua
Paddle = Object:extend()

function Paddle:new(x, y) --constructor method for new Paddle object
    self.x = x
    self.y = y
    self.width = 5
    self.height = 15
    self.speed = 100 --this default value of 100 should equate to 100px/sec
end

function Paddle:update(dt)
    self.y = self.y + (self.speed * dt)
end

function Paddle:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end