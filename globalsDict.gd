extends Node

# ~~~ CONFIGS
var config_maxBotsPerTeam = 3
# ~~~ END CONFIGS

var sessionScore = 0

var playerLineupDict
var enemyLineupDict


func getPlayerLineupDict()->Dictionary:
	if not playerLineupDict:
		return {}
	return playerLineupDict


func getPlayerLineupInstance()->Dictionary:
	if not playerLineupDict:
		return {}
	return playerLineupDict




func setPlayerLineupDict(newPlayerLineupDict:Dictionary):
	playerLineupDict = newPlayerLineupDict






func lineupDictToLineupInstance():
	return


func addBotToTeamFromDict(botDict):
	var newTeamLineup
	print("adding bot dict to global array dict : ", botDict)
	pass




func addBotDictToPlayerLineupDict(botDict):
	print("adding bot dict to global array dict : ", botDict)
	if playerLineupDict.size() + 1 > config_maxBotsPerTeam:
		print("player team is too big")
		return
	playerLineupDict[playerLineupDict.size() + 1] = botDict





# REGULAR


func _ready():
	Events.game_updateScoreBackend.connect(updateBackendScore)
	#Events.game_over.connect(gameOverReset)

func updateBackendScore(newScore):
	sessionScore = newScore
	Events.game_updateScoreFrontend.emit()











