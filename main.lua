_G.love = require("love")

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    death = love.audio.newSource("Sounds/Fail.mp3", "static")
    blip = love.audio.newSource("Sounds/Blip.mp3", "static")
    _G.paddle1 = {}
    paddle1.x = 20
    paddle1.y = 250
    _G.paddle2 = {}
    paddle2.x = 720
    paddle2.y = 250
    _G.ball = {}
    ball.x = 365
    ball.y = 290
    dirX = true
    dirY = true
    score = 0
end

function wallCol()
    if ball.y < 0 or ball.y > 590 then
        dirY = not dirY
    elseif ball.x < 0 or ball.x > 740 then
        dirX = not dirX
        death:play()
        score = 0
        ball.x = 365
        ball.y = math.random(0,590)
        love.timer.sleep(1)
    end
end

function paddleCol()
    if ball.x == 20 and paddle1.y - 10 <= ball.y and ball.y <= paddle1.y + 100 then
        blip:play()
        dirX = true
        score = score + 1
    elseif ball.x == 720 and paddle2.y - 10 <= ball.y and ball.y <= paddle2.y + 100 then
        blip:play()
        dirX = false
        score = score + 1
    end
end

function dirCheck()
    if dirX == true and dirY == true then -- up & right
        ball.x = ball.x + 5
        ball.y = ball.y - 5
    elseif dirX == true and dirY == false then -- down & right
        ball.x = ball.x + 5
        ball.y = ball.y + 5
    elseif dirX == false and dirY == true then -- up & left
        ball.x = ball.x - 5
        ball.y = ball.y - 5
    elseif dirX == false and dirY == false then -- down & left
        ball.x = ball.x - 5
        ball.y = ball.y + 5
    end
end

function love.update(dt)
    if love.keyboard.isDown("w") and paddle1.y > 0 then
        paddle1.y = paddle1.y - 5
    end
    if love.keyboard.isDown("s") and paddle1.y < 500 then
        paddle1.y = paddle1.y + 5
    end
    if love.keyboard.isDown("up") and paddle2.y > 0 then
        paddle2.y = paddle2.y - 5
    end
    if love.keyboard.isDown("down") and paddle2.y < 500 then
        paddle2.y = paddle2.y + 5
    end
    wallCol()
    paddleCol()
    dirCheck()
end

function love.draw()
    love.graphics.print(score, 350, 50, r, 6, 6)
    love.graphics.rectangle("fill",paddle1.x,paddle1.y,10,100)
    love.graphics.rectangle("fill",paddle2.x,paddle2.y,10,100)
    love.graphics.rectangle("fill",ball.x,ball.y,10,10)
end