--ball.lua
Ball = Object:extend()

function Ball:new(x,y)
    self.x = x
    self.y = y
    self.speed = 150
    self.radius = 5
    self.xMod = 0.5
    self.yMod = 0.5
end

function Ball:initialize()
    local thirdWidth = love.graphics.getWidth() / 3
    local thirdHeight = love.graphics.getHeight() / 3

    -- Set the ball's starting position within the 2nd quadrant
    self.x = random(thirdWidth, 2 * thirdWidth)
    self.y = random(thirdHeight / 3, 2 * thirdHeight / 3)

    -- Set the ball's velocity modifiers
    self.xMod = random(0.3, 0.7)  -- Adjust range based on your preference
    self.yMod = 1 - gameBall.xMod

    --Chance for ball to start in either direction
    local directionChance = random(0,1)
    if directionChance == 1 then
	    self.xMod = -self.xMod
    end
end

function Ball:setReflection(angle)
    -- Set the new xMod and yMod based on the calculated angle
    self.xMod = math.cos(angle)
    self.yMod = math.sin(angle)

    -- Reverse the direction
    --self.xMod = -self.xMod
    self.yMod = -self.yMod
end

--[[function Ball:yBoundCheck()
    local yBound = love.graphics.getHeight()

    if (self.y - self.radius <= 0) then
        -- Bounce from top bound
        self.yMod = -self.yMod
        self.y = self.radius + 2  -- Move the ball slightly away from the wall
    elseif (self.y + self.radius >= yBound) then
	 -- Bounce from botttom bound
	self.yMod = -self.yMod
        self.y = yBound - self.radius - 2  -- Move the ball slightly away from the wall
    end
end]]


function Ball:update(dt)
	self.x = self.x + (self.speed * self.xMod * dt)
	self.y = self.y + (self.speed * self.yMod * dt)
	--self:xBoundCheck()
	--self:yBoundCheck()
end

function Ball:draw()
    love.graphics.circle("fill", self.x, self.y, self.radius)
end
