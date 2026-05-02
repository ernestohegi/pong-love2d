local push = require 'push'

local titleFont = nil
local gameWidth, gameHeight = 432, 243
local windowWidth, windowHeight = 1280, 720

windowWidth, windowHeight = windowWidth * 0.8, windowHeight * 0.8

local title = {
  text = 'Hello, Pong!',
  x = 0,
  y = gameHeight / 2 - 12,
  width = gameWidth,
  align = 'center'
}

local player1Keys = {
  up = 'w',
  down = 's'
}

local player2Keys = {
  up = 'up',
  down = 'down'
}

local paddle1 = {
  top = 10,
  left = 10,
  width = 5,
  height = 20
}

local paddle2 = {
  top = gameHeight - 30,
  left = gameWidth - 15,
  width = 5,
  height = 20
}

local ball = {
  top = gameHeight / 2 - 2,
  left = gameWidth / 2 - 2,
  width = 4,
  height = 4
}

local player1Score = {
  top = 10,
  left = gameWidth / 2 - 50,
  width = 20,
  height = 32
}

local player2Score = {
  top = 10,
  left = gameWidth / 2 + 30,
  width = 20,
  height = 32
}

PLAYER_1_SCORE = 0
PLAYER_2_SCORE = 0

PLAYER_1_Y = paddle1.top
PLAYER_2_Y = paddle2.top

PADDLE_SPEED = 200

local function movePaddle(y, paddleHeight, keys, dt)
  if love.keyboard.isDown(keys.up) then
    y = y - PADDLE_SPEED * dt
  elseif love.keyboard.isDown(keys.down) then
    y = y + PADDLE_SPEED * dt
  end

  return math.max(0, math.min(y, gameHeight - paddleHeight))
end

function love.load()
  titleFont = love.graphics.newFont(32)

  love.graphics.setDefaultFilter('nearest', 'nearest')

  love.window.setMode(
    gameWidth, gameHeight,
    {
      vsync = true,
      resizable = false,
      fullscreen = false
    })

  push:setupScreen(
    gameWidth, gameHeight,
    windowWidth, windowHeight,
    { pixelperfect = false }
  )
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

function love.update(dt)
  PLAYER_1_Y = movePaddle(PLAYER_1_Y, paddle1.height, player1Keys, dt)
  PLAYER_2_Y = movePaddle(PLAYER_2_Y, paddle2.height, player2Keys, dt)
end

function love.draw()
  push:start()

  love.graphics.clear(45 / 255, 50 / 255, 52 / 255, 1)
  love.graphics.setFont(titleFont)

  -- Title
  -- love.graphics.printf(title.text, title.x, title.y, title.width, title.align)

  -- Scores
  love.graphics.print(tostring(PLAYER_1_SCORE), player1Score.left, player1Score.top)
  love.graphics.print(tostring(PLAYER_2_SCORE), player2Score.left, player2Score.top)

  -- Paddle 1
  love.graphics.rectangle('fill', paddle1.left, PLAYER_1_Y, paddle1.width, paddle1.height)

  -- Paddle 2
  love.graphics.rectangle('fill', paddle2.left, PLAYER_2_Y, paddle2.width, paddle2.height)

  -- Ball
  love.graphics.rectangle('fill', ball.left, ball.top, ball.width, ball.height)

  push:finish()
end
