
class_name Bot

signal died

var mainDictTemplate = { # "me"
	"label":"defualt label", 
	"sprite":null, 
	"description":"default description", 

	"baseHealth":1,
	"totalHealth":1, 
	"remainingHealth":1,

	"baseAttack":1,
	"totalAttack":1, 

	"attachPoints":1,
	"attach1":{"part":"attach1"},
	"attach2":"attach2",

	"dead":false,
	"lineupPosition":1,
	
	"currentInstanceRef":null
}


var me = {}




func _init(inputDict = null):
	if inputDict:
		me = inputDict
	else:
		me = mainDictTemplate
	if not me.has("totalHealth"):
		me.totalHealth = me.baseHealth
	if not me.has("totalAttack"):
		me.totalAttack = me.baseAttack
	me.remainingHealth = me.totalHealth


func outgoingAttack():
	if isDead():
		return {"damage":0, "fromPosition":1, "toPosition":1}
	return {"damage":me.totalAttack, "fromPosition":1, "toPosition":1}

func takeIncomingAttacks(atkDict):
	#print("bot with health : , ", me.remainingHealth, " taking (atkDict) ", atkDict, " damage")
	me.remainingHealth -= atkDict.damage
	if me.remainingHealth <= 0:
		me.dead = true

func isDead():
	if me.remainingHealth <= 0:
		return true




func toDict():
	return me










