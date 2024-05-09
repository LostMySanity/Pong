
push = require 'push'

Class = require 'class'

require 'Paddle'

require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200


    function love.load()

        love.graphics.setDefaultFilter('nearest','nearest')

        math.randomseed(os.time())

        smallFont = love.graphics.newFont('font.ttf',8)

        love.graphics.setFont(smallFont)

        push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
            fullscreen = false,
            resizable = false,
            vsync = true
        })

        -- player1Score = 0
        -- player2Score = 0

        player1Y = Paddle(10,30,5,20)
        player2Y = Paddle(VIRTUAL_WIDTH - 10,VIRTUAL_HEIGHT - 30,5,20)

        ball = Ball(VIRTUAL_WIDTH / 2-2, VIRTUAL_HEIGHT / 2-2,4,4)
        -- ballX = VIRTUAL_WIDTH / 2-2
        -- bally = VIRTUAL_HEIGHT / 2-2

        -- ballDX = math.random(2) == 1 and 100 or -100
        -- ballDY = math.random(-50,50)

        gameState ='start'
    end

    function love.update(dt)
        if love.keyboard.isDown('w') then
            -- player1Y = player1Y +  -PADDLE_SPEED * dt
            -- player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
            player1.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('s') then
            -- player1Y = player1Y + PADDLE_SPEED * dt
            -- player1Y = math.max(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
            player1.dy = PADDLE_SPEED

            else
                player1.dy = 0
        end


    -- player 2 movement

    if love.keyboard.isDown('up') then
        -- player2Y = player2Y + -PADDLE_SPEED * dt
        -- player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        -- player2Y = player2Y + PADDLE_SPEED * dt
        -- player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    if gameState == 'play' then
        -- ballX = ballX + ballDX * dt
        -- ballY = ballY + ballDY * dt
        ball:update(dt)
    end
    player1:update(dt)
    player2:update(dt)
end

function love.keypressed(key)
         -- keys can be accessed by string name
        if key == 'escape' then
            love.event.quit()
        
        elseif key == 'enter' or key == 'return' then
            if gameState == 'start' then
                gameState = 'play'

            else
                gameState = 'start'

                -- ballX = VIRTUAL_WIDTH /2 -2
                -- ballY = VIRTUAL_HEIGHT / 2-2
                ball:reset()

                 -- given ball's x and y velocity a random starting value
            -- the and/or pattern here is Lua's way of accomplishing a ternary operation
            -- in other programming languages like C
                -- ballDX = math.random(2) == 1 and 100 or -100
                -- ballDY = math.random(-50, 50) * 1.5
            end
        end
     end

    function love.draw()
        push:apply('start')

        love.graphics.clear(40/225,45/255,52/255,255/255)

        love.graphics.setFont('smallFont')

        if gameState == 'start' then
        love.graphics.printf(
            'Hello Start State!',
            0,
            20,
            VIRTUAL_WIDTH,
            'center')
        else
            love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')

        end

            -- love.graphics.setFont(scoreFont)

            -- love.graphics.print(tostring(player1Score),VIRTUAL_WIDTH/2-50, VIRTUAL_HEIGHT/3)

            -- love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH/2+30,VIRTUAL_HEIGHT/3)    
            player1:render()
            -- love.graphics.rectangle('fill',10,player1Y,5,20)
            player2:render()
            -- love.graphics.rectangle('fill',VIRTUAL_WIDTH - 10,player2Y, 5, 20)
            ball:render()
            -- love.graphics.rectangle('fill',ballX,ballY,4,4)
            -- love.graphics.rectangle('fill',VIRTUAL_WIDTH / 2-2,VIRTUAL_HEIGHT / 2 - 2, 4, 4)
            push:apply('end')
    end

