
class_name Team

var teamDictTemplate = { # "me"
	"1":null, # bot dictionary
	"2":null, # bot dictionary
	"3":null, # bot dictionary
} # the key is the position in the lineup, it is important

var team = {}


func _init(inputDict = null):
	if inputDict:
		team = inputDict
	else:
		#print("team init'd without an input dict")
		#team = mainDictTemplate
		pass

func getTeam():
	return team


func getTeamDamage():
	#print("getTeamDamage current team dict is : ", team)
	return team[1].outgoingAttack()


func getBot(pos):
	if team.has(pos):
		return team[pos]

func isDefeated():
	for lPos in team:
		if team[lPos].isDead():
			return true
	return false
		
func resetDefeat():
	pass


func takeAttack(attackDict):
	print("team taking attack : ", attackDict)
	team[1].takeIncomingAttacks(attackDict)

## without creating an instance of the bot class
#func addBotToLineup(bot:Dictionary):
	#var pos = team.size() + 1
	#if pos > Globals.config_maxBotsPerTeam:
		#return
	#bot.position = pos
	#team[pos] = bot

func addBotToLineup(bot:Dictionary):
	var pos = team.size() + 1
	if pos > Globals.config_maxBotsPerTeam:
		return 
	bot.position = pos
	team[pos] = Bot.new(bot)


