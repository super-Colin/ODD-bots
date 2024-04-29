extends Node


# ~~~ CONFIGS
var conf_maxBotsPerTeam = 3
var conf_scoreToWin = 1
var conf_mainTransitionTime = 0.25
var conf_cardSelectionTime = conf_mainTransitionTime
var conf_sceneTransitionTime = 0.5
# ~~~ END CONFIGS


# ~~~ PREFERENCES
var pref_volumeModifier : float = 1
var pref_musicMuted : bool = false
# ~~~ END PREFERENCES


# ~~~ VARS
var gameOver : bool = false
var sessionScore : int = 0
var playerTeam : Dictionary
var enemyTeam : Dictionary
# ~~~ END VARS


func _ready():
	Events.game_updateSessionScore.connect(_game_updateSessionScore)
	Events.game_over.connect(_game_over)
	Events.mode_gameOver.connect(_game_over)


func _game_updateSessionScore(newScore):
	sessionScore = newScore
	Events.game_updateSessionScore.emit()


func _game_over():
	gameOver = true

func game_start():
	gameOver = false
	playerTeam = {}
	sessionScore = 0
	Events.game_start.emit()





