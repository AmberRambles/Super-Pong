function love.load()                     --called once at program load
    io.stdout:setvbuf("no")              --allows the attached console to print content during runtime
    require "src.helpers"                --my personal helper function file
    Object = require "src.classic"       --the classic package by rxi
    randomStartup()                      --primes the Random Number Generator
end

function love.update(dt)                 --dt stands for delta time
    --do stuff
end

function love.draw()                     --only rendering commands here
    love.graphics.print("Hello World", 400, 300)
end