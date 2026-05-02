local Player = {}
Player.__index = Player

function Player.new(x, y, width, height, keys, scoreX, scoreY)
  return setmetatable({
    x = x, y = y,
    width = width, height = height,
    keys = keys,
    scoreX = scoreX, scoreY = scoreY,
    score = 0
  }, Player)
end

function Player:update(dt)
  if love.keyboard.isDown(self.keys.up) then
    self.y = self.y - PADDLE_SPEED * dt
  elseif love.keyboard.isDown(self.keys.down) then
    self.y = self.y + PADDLE_SPEED * dt
  end
  self.y = math.max(0, math.min(self.y, GAME_HEIGHT - self.height))
end

function Player:draw()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Player:drawScore()
  love.graphics.print(tostring(self.score), self.scoreX, self.scoreY)
end

return Player
