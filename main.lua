push = require 'push'

gameWidth, gameHeight = 432, 243
windowWidth, windowHeight = 1280, 720
windowWidth, windowHeight = windowWidth * 0.8, windowHeight * 0.8
titleFont = nil

function love.load()
  titleFont = love.graphics.newFont(24)

  love.graphics.setDefaultFilter('nearest', 'nearest')
  
  love.window.setMode(
    gameWidth, gameHeight, 
    {
      vsync = true,
      resizable = false,
      fullscreen = false
    })
  
  push:setupScreen(
    gameWidth, gameHeight, 
    windowWidth, windowHeight, 
    { pixelperfect = true, stretched = true }
  )
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

function love.draw()
  push:start()

  love.graphics.setFont(titleFont)
  love.graphics.printf('Hello Pong!', 0, gameHeight / 2 - 12, gameWidth, 'center')

  push:finish()
end
