local config = {
  game = {
    width = 432,
    height = 243,
    window = {
      title = "Pong",
      width = 1280 * 0.8,
      height = 720 * 0.8,
    },
    state = {
      start = "start",
      play = "play",
      finished = "finished",
    },
    rules = {
      winScore = 3,
    },
  },
  tuning = {
    speedScale = 1.6,
    paddleSpeed = 200,
    ball = {
      speedX = 100,
      speedYMin = -50,
      speedYMax = 50,
      bounceSpeedMultiplier = 1.07,
    },
  },
  controls = {
    quit = "escape",
    play = "return",
    reset = "space",
  },
  ui = {
    layout = {
      verticalRythm = 16 * 1.5,
      horizontalRythm = 16,
    },
    fonts = {
      path = "assets/fonts/PressStart2P-Regular.ttf",
      sizes = {
        gameTitle = 24,
        title = 12,
        info = 8,
        score = 16,
        winner = 18,
      },
    },
    title = {
      text = "Press Enter to Start",
      x = 0,
      y = 243 / 2 - 12,
      width = 432,
      align = "center",
    },
    messages = {
      gameTitle = "PONG",
      startPrompt = "Press ENTER to start",
      winRule = "First to %d wins",
      controlsHint = "Press ESC to close game, Press SPACE to restart",
      winner = "Player %d won",
      restartHint = "Press ENTER to play again or SPACE to reset.",
    },
  },
  entities = {
    player1 = {
      x = 10,
      y = 10,
      width = 5,
      height = 20,
      keys = { up = "w", down = "s" },
      scoreX = 432 / 2 - 50,
      scoreY = 10,
    },
    player2 = {
      x = 432 - 15,
      y = 243 - 30,
      width = 5,
      height = 20,
      keys = { up = "up", down = "down" },
      scoreX = 432 / 2 + 30,
      scoreY = 10,
    },
    ball = {
      width = 4,
      height = 4,
    },
  },
}

return config
