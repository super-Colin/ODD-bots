
class_name Bot

signal died

var mainDictTemplate = { # "me"
	"label":"label", 
	"sprite":null, 
	"description":"description", 

	"baseHealth":1,
	"totalHealth":1, 
	"remainingHealth":1,

	"baseAttack":1,
	"totalAttack":1, 

	"attachPoints":1,
	"attach1":{"part":"attach1"},
	"attach2":"attach2",

	"dead":false,
	"lineupPosition":1
}


var me


func _init(inputDict = null):
	if inputDict:
		me = inputDict
	else:
		me = mainDictTemplate


func outgoingAttack():
	if isDead():
		return {"damage":0, "fromPosition":1, "toPosition":1}
	#return {"damage":attack, "fromPosition":1, "toPosition":1}

func takeIncomingAttacks(atkDict):
	print("bot with health : , ", me.health, " taking (atkDict) ", atkDict, " damage")
	me.health -= atkDict.damage
	if me.health <= 0:
		me.dead = true

func isDead():
	if me.health <= 0:
		return true












