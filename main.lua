--main.lua
function love.load()                     --called once at program load
    io.stdout:setvbuf("no")              --allows the attached console to print content during runtime
    require "src.helpers"                --my personal helper function file
    Object = require "src.classic"       --the classic package by rxi
    require "src.paddle" --Paddle class
    require "src.ball" --Ball class
    randomStartup()                      --primes the Random Number Generator
    computerPaddle = Paddle(700, 200)
    userPaddle = Paddle(50, 200)
    gameBall = Ball(375, 150)
    
end

function love.update(dt)                 --dt stands for delta time
    computerPaddle:computerUpdate(dt)
    userPaddle:userUpdate(dt)
    gameBall:update(dt)
end

function love.draw()                     --only rendering commands here
    --love.graphics.print("Super Pong!", 400, 100)
    computerPaddle:draw()
    userPaddle:draw()
    gameBall:draw()
end
