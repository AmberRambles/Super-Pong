--main.lua
function love.load()                     --called once at program load
    io.stdout:setvbuf("no")              --allows the attached console to print content during runtime
    require "src.helpers"                --my personal helper function file
    Object = require "src.classic"       --the classic package by rxi
    require "src.paddle" --Paddle class
    require "src.ball" --Ball class
    PAUSE = false
    randomStartup()                      --primes the Random Number Generator
    computerPaddle = Paddle(love.graphics.getWidth() - 50, 200)
    userPaddle = Paddle(50, 200)
    gameBall = Ball(375, 150)
    gameBall:initialize()
    gameBall.width = gameBall.radius
    gameBall.height = gameBall.radius
end

function computerMovement(dt)
	local paddleMid = (computerPaddle.y + computerPaddle.height) / 2
	if paddleMid > gameBall.y then
		computerPaddle.y = computerPaddle.y - (computerPaddle.speed * dt)
	elseif paddleMid < gameBall.y then
		computerPaddle.y = computerPaddle.y + (computerPaddle.speed * dt)
	end
end

function yBoundCheck(dt)
    local yBound = love.graphics.getHeight()

    if (gameBall.y - gameBall.radius <= 0) then
        -- Bounce from top bound
        --self.y = self.radius + 2  -- Move the ball slightly away from the wall
	yBoundCollision(dt)
    elseif (gameBall.y + gameBall.radius >= yBound) then
	 -- Bounce from botttom bound
	--self.yMod = -self.yMod
        --self.y = yBound - self.radius - 2  -- Move the ball slightly away from the wall
	yBoundCollision(dt)

    end
end


function yBoundCollision(dt)
	PAUSE = true
	local ballCenterX = gameBall.x
	local ballCenterY = gameBall.y
	local prevBallX = gameBall.x - (gameBall.speed * gameBall.xMod * dt * 3)
	local prevBallY = gameBall.y - (gameBall.speed * gameBall.yMod * dt * 3)
	local thirdX = ballCenterX
	local thirdY = prevBallY
	local hypotenous = distanceBetweenPoints(ballCenterX, ballCenterY, prevBallX, prevBallY)
	local opposite = distanceBetweenPoints(prevBallX, prevBallY, thirdX, thirdY)
	local sineVal = opposite / hypotenous
	local radianAngle = math.asin(sineVal)
	local reflectedAngle = math.pi - radianAngle
	gameBall.xMod = math.cos(reflectedAngle)
	gameBall.yMod = math.sin(reflectedAngle)
end

function paddleCollision(dt)
	PAUSE = true
	local ballCenterX = gameBall.x
	local ballCenterY = gameBall.y
	local prevBallX = gameBall.x - (gameBall.speed * gameBall.xMod * dt * 3)
	local prevBallY = gameBall.y - (gameBall.speed * gameBall.yMod * dt * 3)
	local thirdX = prevBallX
	local thirdY = ballCenterY
	local hypotenous = distanceBetweenPoints(ballCenterX, ballCenterY, prevBallX, prevBallY)
	local opposite = distanceBetweenPoints(prevBallX, prevBallY, thirdX, thirdY)
	local sineVal = opposite / hypotenous
	local radianAngle = math.asin(sineVal)
	local reflectedAngle = -radianAngle
	gameBall.xMod = math.cos(reflectedAngle)
	gameBall.yMod = math.sin(reflectedAngle)
end

function love.update(dt)		--dt stands for delta time
	if love.keyboard.isDown("p") then
		--print("p down!")
		PAUSE = true
	elseif love.keyboard.isDown("space") then
		PAUSE = false
	end
	if not PAUSE then
		computerMovement(dt)
    		computerPaddle:update()
    		userPaddle:update()
    		userPaddle:userUpdate(dt)
    		gameBall:update(dt)
		yBoundCheck(dt)
    		if computerPaddle:checkCollision(gameBall) then
	    		print("Ball collided with PC paddle")
	    		paddleCollision(dt)
		    elseif userPaddle:checkCollision(gameBall) then
	    		paddleCollision(dt)
	    		print("Ball collided with User Paddle")
    		end
	end
end

function love.draw()                     --only rendering commands here
    --love.graphics.print("Super Pong!", 400, 100)
    computerPaddle:draw()
    userPaddle:draw()
    gameBall:draw()
    love.graphics.line(gameBall.x - gameBall.radius - 5, gameBall.y, gameBall.x + gameBall.radius + 5, gameBall.y)
    if PAUSE then
	love.graphics.print("PAUSED!\nPress SPACE to continue", 400, 100)
    end
end
