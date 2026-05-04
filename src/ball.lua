local config = require("src.config")

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

function Ball:handlePaddleCollision(paddle, side)
  if side == "left" then
    self.x = paddle.x + paddle.width
  elseif side == "right" then
    self.x = paddle.x - self.width
  else
    return
  end

  self.dx = -self.dx * config.tuning.ball.bounceSpeedMultiplier
end

function Ball:handleVerticalBoundaryBounce()
  local bounced = false

  if self.y <= 0 then
    self.y = 0
    self.dy = -self.dy

    bounced = true
  elseif self.y + self.height >= config.game.height then
    self.y = config.game.height - self.height
    self.dy = -self.dy

    bounced = true
  end

  return bounced
end

function Ball:checkHorizontalBoundaryCross()
  if self.x + self.width < 0 then
    return "right"
  elseif self.x > config.game.width then
    return "left"
  end

  return nil
end

function Ball:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Ball:reset()
  local speedScale = config.tuning.speedScale

  self.x = config.game.width / 2 - self.width / 2
  self.y = config.game.height / 2 - self.height / 2
  self.dx = (math.random(2) == 1 and config.tuning.ball.speedX or -config.tuning.ball.speedX)
    * speedScale
  self.dy = math.random(config.tuning.ball.speedYMin, config.tuning.ball.speedYMax) * speedScale
end

return Ball
