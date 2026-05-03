local push = require("lib.push")
local config = require("src.config")
local Player = require("src.player")
local Ball = require("src.ball")
local UIMessages = require("src.ui_messages")

local GAME_START = config.game.state.start
local GAME_PLAY = config.game.state.play
local GAME_FINISHED = config.game.state.finished
local WIN_SCORE = config.game.rules.winScore

local GAME_STATE = GAME_START
local winner = nil

local windowWidth, windowHeight = config.game.window.width, config.game.window.height
local keys = config.controls

local player1 = Player.new(
  config.entities.player1.x,
  config.entities.player1.y,
  config.entities.player1.width,
  config.entities.player1.height,
  config.entities.player1.keys,
  config.entities.player1.scoreX,
  config.entities.player1.scoreY
)

local player2 = Player.new(
  config.entities.player2.x,
  config.entities.player2.y,
  config.entities.player2.width,
  config.entities.player2.height,
  config.entities.player2.keys,
  config.entities.player2.scoreX,
  config.entities.player2.scoreY
)

local ball = Ball.new(
  config.game.width / 2 - config.entities.ball.width / 2,
  config.game.height / 2 - config.entities.ball.height / 2,
  config.entities.ball.width,
  config.entities.ball.height
)

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")

  UIMessages.load(config)

  math.randomseed(os.time())

  love.window.setTitle(config.game.window.title)

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
    if GAME_STATE == GAME_FINISHED then
      player1.score = 0
      player2.score = 0
      winner = nil
      ball:reset()
    end

    GAME_STATE = GAME_PLAY
  elseif key == keys.reset then
    GAME_STATE = GAME_START
    winner = nil

    player1.score = 0
    player2.score = 0

    ball:reset()
  end
end

function love.update(dt)
  if GAME_STATE == GAME_PLAY then
    player1:update(dt)
    player2:update(dt)

    ball:update(dt)
    ball:handleVerticalBoundaryBounce()

    local scorer = ball:checkHorizontalBoundaryCross()

    if scorer == "left" then
      player1.score = player1.score + 1

      if player1.score >= WIN_SCORE then
        winner = 1
        GAME_STATE = GAME_FINISHED
        return
      end

      ball:reset()
      return
    elseif scorer == "right" then
      player2.score = player2.score + 1

      if player2.score >= WIN_SCORE then
        winner = 2
        GAME_STATE = GAME_FINISHED
        return
      end

      ball:reset()
      return
    end

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

  if GAME_STATE == GAME_START then
    UIMessages.drawStart(config, WIN_SCORE)
  end

  if GAME_STATE == GAME_PLAY or GAME_STATE == GAME_FINISHED then
    UIMessages.drawScores(config, player1, player2)
  end

  if GAME_STATE == GAME_PLAY then
    player1:draw()
    player2:draw()
    ball:draw()
  end

  if GAME_STATE == GAME_FINISHED and winner ~= nil then
    UIMessages.drawFinished(config, winner)
  end

  push:finish()
end
