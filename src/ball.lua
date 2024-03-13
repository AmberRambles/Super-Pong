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

function Ball:initialize()
    local thirdWidth = love.graphics.getWidth() / 3
    local thirdHeight = love.graphics.getHeight() / 3

    -- Set the ball's starting position within the 2nd quadrant
    self.x = random(thirdWidth, 2 * thirdWidth)
    self.y = random(thirdHeight / 3, 2 * thirdHeight / 3)

    -- Set the ball's velocity modifiers
    self.xMod = random(0.5, 0.8)  -- Adjust range based on your preference
    self.yMod = 1 - gameBall.xMod

    --Chance for ball to start in either direction
    local directionChance = random(0,1)
    if directionChance == 1 then
	    self.xMod = -self.xMod
    end
end

-- Add a new function bounce to the Ball class
function Ball:bounce(angle)
    local speed = self.speed

    -- Calculate new xMod and yMod based on the angle
    self.xMod = math.cos(angle)
    self.yMod = math.sin(angle)

    -- Reverse the direction
    self.xMod = -self.xMod
    self.yMod = -self.yMod

    -- Update the ball's position slightly to prevent getting stuck in the wall
    self.x = self.x + (self.speed * self.xMod * 0.1)
    self.y = self.y + (self.speed * self.yMod * 0.1)
end

function Ball:yBoundCheck()
    local yBound = love.graphics.getHeight()

    if (self.y - self.radius <= 0) then
        -- Bounce from top bound
	print("bounce top")
        self:bounce(math.rad(90))  -- 90 degrees is the angle for bouncing off the top wall
    elseif (self.y + self.radius >= yBound) then
        -- Bounce from bottom bound
	print("Bounce bottom")
        self:bounce(math.rad(270))  -- 270 degrees is the angle for bouncing off the bottom wall
    end
end

function Ball:xBoundCheck()
    local xBound = love.graphics.getWidth()

    if (self.x - self.radius <= 0) then
        -- Point for the opponent
        print("Point CPU")
        self:initialize()  -- Reset ball position after scoring
    elseif (self.x + self.radius >= xBound) then
        -- Point for the player
        print("Point Player")
        self:initialize()  -- Reset ball position after scoring
    end
end
--[[function Ball:yBoundCheck()
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
]]
function Ball:update(dt)
	self.x = self.x + (self.speed * self.xMod * dt)
	self.y = self.y + (self.speed * self.yMod * dt)
	self:xBoundCheck()
	self:yBoundCheck()
end

function Ball:draw()
    love.graphics.circle("fill", self.x, self.y, self.radius)
end
