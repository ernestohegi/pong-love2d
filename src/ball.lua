local Ball = {}
Ball.__index = Ball

function Ball.new(x, y, width, height)
  local self = setmetatable({
    x = x,
    y = y,
    width = width,
    height = height,
  }, Ball)

  self:reset()

  return self
end

function Ball:update(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
end

function Ball:collides(paddle)
  return self.x < paddle.x + paddle.width
    and paddle.x < self.x + self.width
    and self.y < paddle.y + paddle.height
    and paddle.y < self.y + self.height
end

function Ball:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Ball:reset()
  self.x = GAME_WIDTH / 2 - self.width / 2
  self.y = GAME_HEIGHT / 2 - self.height / 2
  self.dx = math.random(2) == 1 and 100 or -100
  self.dy = math.random(-50, 50)
end

return Ball
