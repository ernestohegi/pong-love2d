local Sounds = {}

local paddleHitSound = nil
local verticalBounceSound = nil
local scoreSound = nil

function Sounds.load(config)
  paddleHitSound = love.audio.newSource(config.audio.sounds.paddleHit, "static")
  verticalBounceSound = love.audio.newSource(config.audio.sounds.verticalBounce, "static")
  scoreSound = love.audio.newSource(config.audio.sounds.score, "static")

  local sfxVolume = config.audio.volume.sfx

  paddleHitSound:setVolume(sfxVolume)
  verticalBounceSound:setVolume(sfxVolume)
  scoreSound:setVolume(sfxVolume)
end

function Sounds.playPaddleHit()
  if paddleHitSound ~= nil then
    love.audio.play(paddleHitSound:clone())
  end
end

function Sounds.playVerticalBounce()
  if verticalBounceSound ~= nil then
    love.audio.play(verticalBounceSound:clone())
  end
end

function Sounds.playScore()
  if scoreSound ~= nil then
    scoreSound:stop()
    scoreSound:play()
  end
end

return Sounds
