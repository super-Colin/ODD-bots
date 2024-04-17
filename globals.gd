extends Node

# ~~~ CONFIGS
var maxBotsPerTeam = 3
# ~~~ END CONFIGS

# ~~~ PREFERENCES
var volume
var musicMuted = false
# ~~~ END PREFERENCES





var sessionScore = 0

var playerLineupDict
var enemyLineupDict

func _ready():
	Events.game_updateScoreBackend.connect(updateScore)
	Events.game_over.connect(gameOverReset)



func updateScore(newScore):
	sessionScore = newScore
	Events.game_updateScoreFrontend.emit()




func getPlayerLineup():
	if not playerLineup:
		playerLineup = Globals.enemyLineupDict
	return playerLineup

func lineupDictToLineup():
	return


func addBotToTeamFromDict(botDict):
	var newTeamLineup
	print("adding bot dict to global array dict : ", botDict)
	pass






# REGULAR











# OLD


var playerTeam
var playerLineup

var enemyTeam
var enemyLineup



func gameOverReset():
	sessionScore = 0
	playerTeam = null
	playerLineup = null
	playerLineupDict = null
	enemyLineupDict = null
	Events.game_updateScoreFrontend.emit()

func makeTimeout(time):
	await get_tree().create_timer(time).timeout
	return











