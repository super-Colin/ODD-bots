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
var playerTeam : Team
var enemyTeam : Team
# ~~~ END VARS


func _ready():
	Events.game_updateSessionScore.connect(_game_updateSessionScore)
	Events.game_over.connect(_game_over)


func _game_updateSessionScore(newScore):
	sessionScore = newScore
	Events.game_updateScoreFrontend.emit()


func _game_over():
	sessionScore = 0
	gameOver = true
	playerTeam = null

func game_start():
	gameOver = false
	Events.game_start.emit()






