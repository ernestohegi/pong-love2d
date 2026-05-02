local config = {
  game = {
    width = 432,
    height = 243
  },
  paddleSpeed = 200,
  window = {
    title = 'Love 2D Pong',
    width = 1280 * 0.8,
    height = 720 * 0.8
  },
  keys = {
    quit = 'escape',
    play = 'return',
    reset = 'space'
  },
  title = {
    text = 'Hello, Pong!',
    x = 0,
    y = 243 / 2 - 12,
    width = 432,
    align = 'center'
  },
  player1 = {
    x = 10, y = 10,
    width = 5, height = 20,
    keys = { up = 'w', down = 's' },
    scoreX = 432 / 2 - 50, scoreY = 10
  },
  player2 = {
    x = 432 - 15, y = 243 - 30,
    width = 5, height = 20,
    keys = { up = 'up', down = 'down' },
    scoreX = 432 / 2 + 30, scoreY = 10
  }
}

return config
