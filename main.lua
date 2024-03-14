--main.lua
function love.load()                     --called once at program load
    io.stdout:setvbuf("no")              --allows the attached console to print content during runtime
    require "src.helpers"                --my personal helper function file
    Object = require "src.classic"       --the classic package by rxi
    require "src.paddle" --Paddle class
    require "src.ball" --Ball class
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

function love.update(dt)                 --dt stands for delta time
    computerMovement(dt)
    computerPaddle:computerUpdate(dt)
    userPaddle:userUpdate(dt)
    gameBall:update(dt)
    if computerPaddle:checkCollision(gameBall) then
	    print("Ball collided with PC paddle")
    elseif userPaddle:checkCollision(gameBall) then
	    print("Ball collided with User Paddle")
    end
end

function love.draw()                     --only rendering commands here
    --love.graphics.print("Super Pong!", 400, 100)
    computerPaddle:draw()
    userPaddle:draw()
    gameBall:draw()
end
