-- main.lua

local gameState = "menu"  -- Set initial game state to menu

function love.load()
    io.stdout:setvbuf("no")
    require "src.helpers"
    Object = require "src.classic"
    require "src.paddle"
    require "src.ball"
    PAUSE = false
    randomStartup()
    computerPaddle = Paddle(love.graphics.getWidth() - 15, 200)
    userPaddle = Paddle(15, 200)
    gameBall = Ball(375, 150)
    gameBall:initialize()
    gameBall.width = gameBall.radius
    gameBall.height = gameBall.radius
    paddleMid = computerPaddle.y + (computerPaddle.height / 2)
    score = { user = 0, computer = 0 }
    haleysFont = "fonts/FlatfaceHaleys-Sans.otf"
    love.graphics.setNewFont(haleysFont, 32)
    paddleSfx = love.audio.newSource("sounds/tone1.ogg", "static")
    ballResetSfx = love.audio.newSource("sounds/twoTone1.ogg", "static")
end

function love.update(dt)
    if gameState == "menu" then
        -- Check for start or quit input
        if love.keyboard.isDown("return") then
            gameState = "playing"
        elseif love.keyboard.isDown("escape") then
            love.event.quit()
        end
    elseif gameState == "playing" then
        -- Game logic for playing state
        if love.keyboard.isDown("p") then
            PAUSE = true
        elseif love.keyboard.isDown("space") then
            PAUSE = false
        elseif love. keyboard.isDown("escape") then
		love.event.quit()
        end
        if not PAUSE then
            -- Game update logic here
            computerMovement(dt)
            computerPaddle:update()
            userPaddle:update()
            userPaddle:userUpdate(dt)
            gameBall:update(dt)
            yBoundCheck(dt)
            xBoundCheck()
            if computerPaddle:checkCollision(gameBall) then
                gameBall.xMod = -gameBall.xMod
                gameBall.x = gameBall.x - 1
		paddleSfx:play()
            elseif userPaddle:checkCollision(gameBall) then
                gameBall.xMod = -gameBall.xMod
                gameBall.x = gameBall.x + 1
		paddleSfx:play()
            end
        end
    end
end

function love.draw()
    if gameState == "menu" then
        -- Draw the menu
        love.graphics.printf("Super Pong", 0, love.graphics.getHeight() / 3, love.graphics.getWidth(), "center")
        love.graphics.printf("Press Enter to Start\nPress Esc to Quit\nPress P to Pause", 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
    elseif gameState == "playing" then
        -- Draw the game
        local movingY = 0
        local midScreen = love.graphics.getWidth() / 2
        while (movingY < love.graphics.getHeight()) do
            love.graphics.line(midScreen, movingY, midScreen, movingY + 5)
            movingY = movingY + 25
        end
        love.graphics.print("" .. score.user, midScreen - 40, love.graphics.getHeight() / 10)
        love.graphics.print("" .. score.computer, midScreen + 20, love.graphics.getHeight() / 10)
        computerPaddle:draw()
        userPaddle:draw()
        gameBall:draw()
        if PAUSE then
            love.graphics.print("PAUSED!\nPress SPACE to Continue\n\nPress Escape to Quit", 400, 100)
        end
    end
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
        gameBall.yMod = -gameBall.yMod
        gameBall.y = gameBall.radius + 1
    elseif (gameBall.y + gameBall.radius >= yBound) then
        gameBall.yMod = -gameBall.yMod
        gameBall.y = yBound - gameBall.radius - 1
    end
end

function xBoundCheck()
    local xBound = love.graphics.getWidth()

    if (gameBall.x - gameBall.radius <= 0) then
        score.computer = score.computer + 1
	ballResetSfx:play()
        gameBall:initialize()
    elseif (gameBall.x + gameBall.radius >= xBound) then
        score.user = score.user + 1
        ballResetSfx:play()
	gameBall:initialize()
    end
end

