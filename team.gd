
class_name Team

var mainDictTemplate = { # "me"
	#"1":null, # bot dictionary
	#"2":null, # bot dictionary
	#"3":null, # bot dictionary
} # the key is the position in the lineup, it is important

var team = {}


func _init(inputDict = null):
	if inputDict:
		team = inputDict
	else:
		team = mainDictTemplate

func getTeam():
	return team


func getTeamDamage():
	pass





func addBotToTeam(bot:Dictionary):
	var pos = team.size() + 1
	bot.position = pos
	team[ team.size() + 1] = bot


