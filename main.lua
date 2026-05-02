GAME_WIDTH, GAME_HEIGHT = 432, 243
PADDLE_SPEED          = 200

local push   = require 'push'
local Player = require 'player'
local Ball   = require 'ball'

local titleFont = nil
local windowWidth  = 1280 * 0.8
local windowHeight = 720  * 0.8

local GAME_STATE = 'start'

local keys = {
  quit  = 'escape',
  play  = 'return',
  reset = 'space'
}

local title = {
  text  = 'Hello, Pong!',
  x     = 0,
  y     = GAME_HEIGHT / 2 - 12,
  width = GAME_WIDTH,
  align = 'center'
}

local player1Config = {
  x = 10, y = 10,
  width = 5, height = 20,
  keys = { up = 'w', down = 's' },
  scoreX = GAME_WIDTH / 2 - 50, scoreY = 10
}

local player2Config = {
  x = GAME_WIDTH - 15, y = GAME_HEIGHT - 30,
  width = 5, height = 20,
  keys = { up = 'up', down = 'down' },
  scoreX = GAME_WIDTH / 2 + 30, scoreY = 10
}

local player1 = Player.new(
  player1Config.x, player1Config.y,
  player1Config.width, player1Config.height,
  player1Config.keys,
  player1Config.scoreX, player1Config.scoreY
)

local player2 = Player.new(
  player2Config.x, player2Config.y,
  player2Config.width, player2Config.height,
  player2Config.keys,
  player2Config.scoreX, player2Config.scoreY
)

local ball = Ball.new(GAME_WIDTH / 2 - 2, GAME_HEIGHT / 2 - 2, 4, 4)

function love.load()
  titleFont = love.graphics.newFont(32)
  math.randomseed(os.time())
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setMode(GAME_WIDTH, GAME_HEIGHT, {
    vsync = true, resizable = false, fullscreen = false
  })
  push:setupScreen(GAME_WIDTH, GAME_HEIGHT, windowWidth, windowHeight,
    { pixelperfect = false })
end

function love.keypressed(key)
  if key == keys.quit then
    love.event.quit()
  elseif key == keys.play then
    GAME_STATE = 'play'
  elseif key == keys.reset then
    GAME_STATE = 'start'
    player1.score = 0
    player2.score = 0
    ball:reset()
  end
end

function love.update(dt)
  player1:update(dt)
  player2:update(dt)
  if GAME_STATE == 'play' then ball:update(dt) end
end

function love.draw()
  push:start()
  love.graphics.clear(45/255, 50/255, 52/255, 1)
  love.graphics.setFont(titleFont)
  if GAME_STATE == 'start' then
    love.graphics.printf(title.text, title.x, title.y, title.width, title.align)
  end
  if GAME_STATE == 'play' then
    player1:drawScore()
    player2:drawScore()
    player1:draw()
    player2:draw()
    ball:draw()
  end
  push:finish()
end
