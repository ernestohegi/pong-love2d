local UIMessages = {}
local fonts = {}

function UIMessages.load(config)
  local fontPath = config.ui.fonts.path
  local sizes = config.ui.fonts.sizes

  fonts.gameTitle = love.graphics.newFont(fontPath, sizes.gameTitle, "mono")
  fonts.title = love.graphics.newFont(fontPath, sizes.title, "mono")
  fonts.info = love.graphics.newFont(fontPath, sizes.info, "mono")
  fonts.score = love.graphics.newFont(fontPath, sizes.score, "mono")
  fonts.winner = love.graphics.newFont(fontPath, sizes.winner, "mono")
end

function UIMessages.drawScores(config, player1, player2)
  love.graphics.setFont(fonts.score)
  player1:drawScore()
  player2:drawScore()
  UIMessages.drawScoreLabels(config, player1, player2)
end

function UIMessages.drawScoreLabels(config, player1, player2)
  love.graphics.setFont(fonts.info)
  love.graphics.print(
    "Player 1",
    player1.scoreX - config.ui.layout.horizontalRythm * 5,
    player1.scoreY + 4
  )
  love.graphics.print(
    "Player 2",
    player2.scoreX + config.ui.layout.horizontalRythm * 2,
    player2.scoreY + 4
  )
end

function UIMessages.drawStart(config, winScore)
  local title = config.ui.title
  local messages = config.ui.messages
  local layout = config.ui.layout

  local titleY = title.y - layout.verticalRythm * 3
  local startPromptY = titleY + layout.verticalRythm * 3
  local winRuleY = startPromptY + layout.verticalRythm * 2
  local controlsY = winRuleY + layout.verticalRythm

  love.graphics.setFont(fonts.gameTitle)
  love.graphics.printf(messages.gameTitle, 0, titleY, config.game.width, "center")

  love.graphics.setFont(fonts.title)
  love.graphics.printf(messages.startPrompt, title.x, startPromptY, title.width, title.align)

  love.graphics.setFont(fonts.info)
  love.graphics.printf(
    string.format(messages.winRule, winScore),
    0,
    winRuleY,
    config.game.width,
    "center"
  )
  love.graphics.printf(messages.controlsHint, 0, controlsY, config.game.width, "center")
end

function UIMessages.drawFinished(config, winner)
  local messages = config.ui.messages
  local layout = config.ui.layout
  local winnerY = config.game.height / 2 - layout.verticalRythm
  local promptY = winnerY + layout.verticalRythm * 2

  love.graphics.setFont(fonts.winner)
  love.graphics.printf(
    string.format(messages.winner, winner),
    0,
    winnerY,
    config.game.width,
    "center"
  )

  love.graphics.setFont(fonts.info)
  love.graphics.printf(messages.restartHint, 0, promptY, config.game.width, "center")
end

return UIMessages
