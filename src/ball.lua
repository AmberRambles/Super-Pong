--ball.lua
Ball = Object:extend()

function Ball:new(x,y)
    self.x = x
    self.y = y
    self.speed = 100
    self.radius = 5
end

function Ball:update(dt)
    --self.x = self.x + (self.speed * dt)
end

function Ball:draw()
    love.graphics.circle("fill", self.x, self.y, self.radius)
end
