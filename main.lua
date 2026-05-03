local push = require("lib.push")
local config = require("src.config")
local Player = require("src.player")
local Ball = require("src.ball")

local GAME_STATE = "start"

local titleFont = nil
local windowWidth, windowHeight = config.window.width, config.window.height
local keys, title = config.keys, config.title

local player1 = Player.new(
  config.player1.x,
  config.player1.y,
  config.player1.width,
  config.player1.height,
  config.player1.keys,
  config.player1.scoreX,
  config.player1.scoreY
)

local player2 = Player.new(
  config.player2.x,
  config.player2.y,
  config.player2.width,
  config.player2.height,
  config.player2.keys,
  config.player2.scoreX,
  config.player2.scoreY
)

local ball = Ball.new(
  config.game.width / 2 - config.ball.width / 2,
  config.game.height / 2 - config.ball.height / 2,
  config.ball.width,
  config.ball.height
)

function love.load()
  titleFont = love.graphics.newFont(32)

  math.randomseed(os.time())

  love.window.setTitle(config.window.title)

  love.graphics.setDefaultFilter("nearest", "nearest")

  love.window.setMode(config.game.width, config.game.height, {
    vsync = true,
    resizable = false,
    fullscreen = false,
  })

  push:setupScreen(
    config.game.width,
    config.game.height,
    windowWidth,
    windowHeight,
    { pixelperfect = false }
  )
end

function love.keypressed(key)
  if key == keys.quit then
    love.event.quit()
  elseif key == keys.play then
    GAME_STATE = "play"
  elseif key == keys.reset then
    GAME_STATE = "start"

    player1.score = 0
    player2.score = 0

    ball:reset()
  end
end

function love.update(dt)
  player1:update(dt)
  player2:update(dt)

  if GAME_STATE == "play" then
    ball:update(dt)
    ball:handleVerticalBoundaryBounce()

    if ball:collides(player1) then
      ball:handlePaddleCollision(player1, "left")
    elseif ball:collides(player2) then
      ball:handlePaddleCollision(player2, "right")
    end
  end
end

function love.draw()
  push:start()

  love.graphics.clear(45 / 255, 50 / 255, 52 / 255, 1)
  love.graphics.setFont(titleFont)

  if GAME_STATE == "start" then
    love.graphics.printf(title.text, title.x, title.y, title.width, title.align)
  end

  if GAME_STATE == "play" then
    player1:drawScore()
    player2:drawScore()
    player1:draw()
    player2:draw()
    ball:draw()
  end

  push:finish()
end
