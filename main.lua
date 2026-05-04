local push = require("lib.push")
local config = require("src.config")
local Player = require("src.player")
local Ball = require("src.ball")
local UI = require("src.ui")
local Sounds = require("src.sounds")

local WIN_SCORE = config.game.rules.winScore
local GAME_STATE = config.game.state.start

local windowWidth, windowHeight =
  config.game.window.width, config.game.window.height
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

local function drawStartState()
  UI.drawStart(config, WIN_SCORE)
end

local function drawPlayState()
  UI.drawScores(config, player1, player2)
  UI.drawCenterDivider(config)
  player1:draw()
  player2:draw()
  ball:draw()
end

local function drawFinishedState()
  UI.drawScores(config, player1, player2)
  local finishedWinner = player1.score > player2.score and 1 or 2
  UI.drawFinished(config, finishedWinner)
end

local drawByState = {
  [config.game.state.start] = drawStartState,
  [config.game.state.play] = drawPlayState,
  [config.game.state.finished] = drawFinishedState,
}

local function resetMatch()
  player1.score = 0
  player2.score = 0
  ball:reset()
end

local function handleQuitKey()
  love.event.quit()
end

local function handlePlayKey()
  if GAME_STATE == config.game.state.finished then
    resetMatch()
  end

  GAME_STATE = config.game.state.play
end

local function handleResetKey()
  GAME_STATE = config.game.state.start
  resetMatch()
end

local keyHandlers = {
  [keys.quit] = handleQuitKey,
  [keys.play] = handlePlayKey,
  [keys.reset] = handleResetKey,
}

local function handlePaddleHit(player, side)
  ball:handlePaddleCollision(player, side)
  Sounds.playPaddleHit()
end

local function awardPoint(player)
  player.score = player.score + 1

  Sounds.playScore()

  if player.score >= WIN_SCORE then
    GAME_STATE = config.game.state.finished
    return true
  end

  ball:reset()

  return true
end

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")

  UI.load(config)
  Sounds.load(config)

  love.math.setRandomSeed(os.time() + love.timer.getTime())

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

function love.resize(w, h)
  push:resize(w, h)
end

function love.keypressed(key)
  local handleKey = keyHandlers[key]

  if handleKey then
    handleKey()
  end
end

function love.update(dt)
  dt = math.min(dt, 1 / 30)

  if GAME_STATE == config.game.state.play then
    player1:update(dt)
    player2:update(dt)
    ball:update(dt)

    if ball:handleVerticalBoundaryBounce() then
      Sounds.playVerticalBounce()
    end

    local scorer = ball:checkHorizontalBoundaryCross()

    if scorer == "left" then
      awardPoint(player1)
      return
    elseif scorer == "right" then
      awardPoint(player2)
      return
    end

    if ball:collides(player1) then
      handlePaddleHit(player1, "left")
    elseif ball:collides(player2) then
      handlePaddleHit(player2, "right")
    end
  end
end

function love.draw()
  push:start()

  love.graphics.clear(45 / 255, 50 / 255, 52 / 255, 1)

  local drawState = drawByState[GAME_STATE]

  if drawState then
    drawState()
  end

  push:finish()
end
