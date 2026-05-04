local config = require("src.config")

local Player = {}
Player.__index = Player

function Player.new(x, y, width, height, keys, scoreX, scoreY)
  return setmetatable({
    x = x,
    y = y,
    width = width,
    height = height,
    keys = keys,
    scoreX = scoreX,
    scoreY = scoreY,
    score = 0,
  }, Player)
end

function Player:update(dt)
  local paddleSpeed = config.tuning.paddleSpeed * config.tuning.speedScale

  if love.keyboard.isDown(self.keys.up) then
    self.y = self.y - paddleSpeed * dt
  elseif love.keyboard.isDown(self.keys.down) then
    self.y = self.y + paddleSpeed * dt
  end

  self.y = math.max(0, math.min(self.y, config.game.height - self.height))
end

function Player:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Player
