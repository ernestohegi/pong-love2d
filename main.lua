local push = require("lib.push")
local config = require("src.config")
local Player = require("src.player")
local Ball = require("src.ball")
local UI = require("src.ui")

local WIN_SCORE = config.game.rules.winScore
local GAME_STATE = config.game.state.start

local winner = nil
local scoreSound = nil

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

local function awardPoint(player, playerNum)
  player.score = player.score + 1

  if scoreSound ~= nil then
    scoreSound:stop()
    scoreSound:play()
  end

  if player.score >= WIN_SCORE then
    winner = playerNum
    GAME_STATE = config.game.state.finished
    return true
  end

  ball:reset()
  return true
end

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")

  UI.load(config)
  Player.loadAudio()
  Ball.loadAudio()
  scoreSound = love.audio.newSource(config.audio.sounds.score, "static")
  scoreSound:setVolume(config.audio.volume.sfx)

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
  if key == keys.quit then
    love.event.quit()
  elseif key == keys.play then
    if GAME_STATE == config.game.state.finished then
      player1.score = 0
      player2.score = 0
      winner = nil
      ball:reset()
    end

    GAME_STATE = config.game.state.play
  elseif key == keys.reset then
    GAME_STATE = config.game.state.start
    winner = nil

    player1.score = 0
    player2.score = 0

    ball:reset()
  end
end

function love.update(dt)
  dt = math.min(dt, 1 / 30)

  if GAME_STATE == config.game.state.play then
    player1:update(dt)
    player2:update(dt)

    ball:update(dt)
    ball:handleVerticalBoundaryBounce()

    local scorer = ball:checkHorizontalBoundaryCross()

    if scorer == "left" then
      awardPoint(player1, 1)
      return
    elseif scorer == "right" then
      awardPoint(player2, 2)
      return
    end

    if ball:collides(player1) then
      ball:handlePaddleCollision(player1, "left")
      player1:playHitSound()
    elseif ball:collides(player2) then
      ball:handlePaddleCollision(player2, "right")
      player2:playHitSound()
    end
  end
end

function love.draw()
  push:start()

  love.graphics.clear(45 / 255, 50 / 255, 52 / 255, 1)

  if GAME_STATE == config.game.state.start then
    UI.drawStart(config, WIN_SCORE)
  end

  if GAME_STATE == config.game.state.play or GAME_STATE == config.game.state.finished then
    UI.drawScores(config, player1, player2)
  end

  if GAME_STATE == config.game.state.play then
    UI.drawCenterDivider(config)
    player1:draw()
    player2:draw()
    ball:draw()
  end

  if GAME_STATE == config.game.state.finished and winner ~= nil then
    UI.drawFinished(config, winner)
  end

  push:finish()
end
