
class_name Team

var mainDictTemplate = { # "me"
	"1":null, # bot dictionary
	"2":null, # bot dictionary
	"3":null, # bot dictionary
} # the key is the position in the lineup, it is important

var me = {}

func _init(inputDict = null):
	if inputDict:
		me = inputDict
	else:
		me = mainDictTemplate



func getTeamDamage():
	pass

func instantiateBots():
	var a

func toDict():
	var p
	for i in me:
		pass
	return {}


func addBotToTeam(bot:Dictionary):
	var currentBots = me.size()
	me[currentBots + 1] = bot


