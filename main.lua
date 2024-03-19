--main.lua
function love.load()                     --called once at program load
    io.stdout:setvbuf("no")              --allows the attached console to print content during runtime
    require "src.helpers"                --my personal helper function file
    Object = require "src.classic"       --the classic package by rxi
    require "src.paddle"                 --Paddle class
    require "src.ball"                   --Ball class
    PAUSE = false
    randomStartup()                      --primes the Random Number Generator
    computerPaddle = Paddle(love.graphics.getWidth() - 15, 200)
    userPaddle = Paddle(15, 200)
    gameBall = Ball(375, 150)
    gameBall:initialize()
    gameBall.width = gameBall.radius
    gameBall.height = gameBall.radius
    paddleMid = computerPaddle.y + (computerPaddle.height / 2)
    score = {}
    score.user = 0
    score.computer = 0
end

function computerMovement(dt)
	paddleMid = computerPaddle.y + (computerPaddle.height / 2)
	if paddleMid > (gameBall.y + gameBall.radius) then
		computerPaddle.y = computerPaddle.y - (computerPaddle.speed * dt)
	elseif paddleMid < (gameBall.y + gameBall.radius) then
		computerPaddle.y = computerPaddle.y + (computerPaddle.speed * dt)
	end
end

function yBoundCheck(dt)
    local yBound = love.graphics.getHeight()

    if (gameBall.y - gameBall.radius <= 0) then
        -- Bounce from top bound
	gameBall.yMod = -gameBall.yMod
        gameBall.y = gameBall.radius + 1  -- Move the ball slightly away from the wall
    elseif (gameBall.y + gameBall.radius >= yBound) then
	 -- Bounce from botttom bound
	gameBall.yMod = -gameBall.yMod
        gameBall.y = yBound - gameBall.radius - 1  -- Move the ball slightly away from the wall

    end
end

function xBoundCheck()
    local xBound = love.graphics.getWidth()

    if (gameBall.x - gameBall.radius <= 0) then
        -- Point for the opponent
        print("Point CPU")
	score.computer = score.computer + 1
	print(score.computer)
        gameBall:initialize()  -- Reset ball position after scoring
    elseif (gameBall.x + gameBall.radius >= xBound) then
        -- Point for the player
        print("Point Player")
	score.user = score.user + 1
	print(score.user)
        gameBall:initialize()  -- Reset ball position after scoring
    end
end


function love.update(dt)		--dt stands for delta time
	if love.keyboard.isDown("escape") then
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
		xBoundCheck()
    		if computerPaddle:checkCollision(gameBall) then
	    		print("Ball collided with PC paddle")
			gameBall.xMod = -gameBall.xMod
			gameBall.x = gameBall.x - 1
		elseif userPaddle:checkCollision(gameBall) then
	    		print("Ball collided with User Paddle")
			gameBall.xMod = -gameBall.xMod
			gameBall.x = gameBall.x + 1
    		end
	end
end

function love.draw()                     --only rendering commands here
    --love.graphics.print("Super Pong!", 400, 100)
    local movingY = 0
    local midScreen = love.graphics.getWidth() / 2
    --prints center line
    while (movingY < love.graphics.getHeight()) do
	love.graphics.line(midScreen, movingY, midScreen, movingY + 5)
	movingY = movingY + 25
    end
    love.graphics.print("" .. score.user, midScreen - 20, love.graphics.getHeight() / 10)
    love.graphics.print("" .. score.computer, midScreen + 20, love.graphics.getHeight() / 10)
    computerPaddle:draw()
    userPaddle:draw()
    gameBall:draw()
    --love.graphics.line(gameBall.x - gameBall.radius - 5, gameBall.y, gameBall.x + gameBall.radius + 5, gameBall.y)
    if PAUSE then
	love.graphics.print("PAUSED!\nPress SPACE to continue", 400, 100)
    end
end
