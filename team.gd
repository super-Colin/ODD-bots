
class_name Team

var teamDictTemplate = { # "me"
	"1":null, # bot dictionary
	"2":null, # bot dictionary
	"3":null, # bot dictionary
} # the key is the position in the lineup, it is important

var team = {}
var botInstances ={}
var totalBots = 0


func _init(inputDict = null):
	if inputDict:
		team = inputDict

func getTeam():
	return team

func getTeamBots():
	var botInstances = {}
	for lPos in team:
		team[lPos].position = lPos
		botInstances[lPos] = Bot.new(team[lPos])

func getTeamCopy():
	var teamCopy = Team.new()
	for lPos in team:
		teamCopy.addBotToLineup(team[lPos])
	return teamCopy


func getTeamDict():
	return team


func getTeamDamage():
	#print("getTeamDamage current team dict is : ", team)
	return botInstances[1].outgoingAttack()


func getBot(pos):
	if botInstances.has(pos):
		return botInstances[pos]
	else:
		print("that bot position isn't there")

func isDefeated():
	for lPos in botInstances:
		if botInstances[lPos].isDead():
			return true
	return false
		
func resetDefeat():
	for lPos in botInstances:
		botInstances[lPos].reset()


func takeAttack(attackDict):
	print("team taking attack : ", attackDict)
	botInstances[1].takeIncomingAttacks(attackDict)


func addBotToLineup(bot:Dictionary):
	totalBots += 1
	var pos = team.size() + 1
	if pos > Globals.config_maxBotsPerTeam:
		return 
	bot.position = pos
	team[pos] = bot
	botInstances[pos] = Bot.new(bot)


