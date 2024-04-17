extends Node

# ~~~ CONFIGS
var config_maxBotsPerTeam = 3
var config_mainTransitionTime = 0.25
var config_cardSelectionTime = config_mainTransitionTime
var config_sceneTransitionTime = 0.5
# ~~~ END CONFIGS

# ~~~ PREFERENCES
var volume
var musicMuted = false
# ~~~ END PREFERENCES

# ~~~ VARS
var gameOver = false
var sessionScore = 0
var playerTeam
var enemyTeam
# ~~~ END VARS


func _ready():
	Events.game_updateSessionScore.connect(updateScore)
	Events.game_over.connect(gameOverReset)


func updateScore(newScore):
	sessionScore = newScore
	Events.game_updateScoreFrontend.emit()


func gameOverReset():
	sessionScore = 0
	playerTeam = null








