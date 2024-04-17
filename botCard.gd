extends Node2D 

var botCardScene = preload("res://botCard.tscn")

signal fullClicked(_self)


var clickInitiated

var label
var description
var sprite

var baseHealth
var health

var baseAttack
var attack

var attachPoints
var attach1
var attach2

var dead = false
var lineupPosition



func _ready():
	$Area2D.input_event.connect(isClickedEvent)
	$Area2D.mouse_exited.connect(func():clickInitiated = false)
	#print("tree is ", get_tree())




func isClickedEvent(_vPort, eve, _shape):
	if eve is InputEventMouseButton:
		if eve.pressed:
			clickInitiated = true
		if clickInitiated and eve.pressed == false:
			clickInitiated = false
			fullClicked.emit($'.')
			#print("Full Click !!! ")
		#print("I was clicked!!! ", eve)

	#if eve == "InputEventMouseButton":
		#print("I was clicked!!!")


func select():
	$'.'.scale = Vector2(1.2,1.2)

func unselect():
	$'.'.scale = Vector2(1,1)


func outgoingAttack():
	if dead:
		return {"damage":0, "fromPosition":1, "toPosition":1}
	return {"damage":attack, "fromPosition":1, "toPosition":1}

func takeIncomingAttacks(atkDict):
	print("bot with health : , ", health, " taking (atkDict) ", atkDict, " damage")
	health -= atkDict.damage
	if health <= 0:
		dead = true
		health = 0
		print("bot died from attack : , ", atkDict)
		#select()
		print("calling effect from incoming damage, becuase bot is dead")
		shakeEffect()
		updateFace(true)
		print("returning false after taking dmg")
		return false
	#print("in incoming dmg tree is ", get_tree())
	#select()
	shakeEffect()
	updateFace()
	return true



func shakeEffect():
	#await Globals.makeTimeout(1.5)
	##print("shifting card right, from ", $'.'.position , " -- self is : ", $'.')
	#$'.'.position = Vector2(100, 0)
	#await Globals.makeTimeout(1.5)
	##print("global timeout finished")
	##print("shifting card left, from ", $'.'.position)
	#$'.'.position = Vector2(0, 0)
	pass





func updateFace(debug=false):
	if debug: print("updating face")
	%Label.text = label
	if description:
		#print("updating description")
		%Description.text = description
	if sprite:
		#print("updating sprite")
		var tex = load(sprite)
		%cardSprite.texture = tex
	if attack or attack == 0:
		#print("updating attack from ", %Attack.text, ", to : ", str(attack))
		%Attack.text = str(attack)
	if debug: print("updating health from ", %Health.text, ", to : ", str(health))
	%Health.text = str(health)
	if debug: print("new health is ", %Health.text)





func fillInFromDict(botDict):
	label = botDict.label
	sprite = botDict.sprite
	description = botDict.description

	baseAttack = botDict.baseAttack
	baseHealth = botDict.baseHealth
	health = botDict.health if botDict.has("health") else botDict.baseHealth
	attack = botDict.attack if botDict.has("attack") else botDict.baseAttack
	if botDict.has("attach1"):
			attach1 = botDict.attach1
	if botDict.has("attach2"):
		attach2 = botDict.attach2
	updateStatsWithParts()
	updateFace()



func cloneSelf():
	var cloneDict = {
		"label":label, 
		"sprite":sprite, 
		"description":description, 
		"baseHealth":baseHealth,
		"health":health, 
		"baseAttack":baseAttack,
		"attack":attack, 
		"attachPoints":attachPoints,
		"attach1":attach1,
		"attach2":attach2,
		"lineupPosition":lineupPosition
		}
	var newCloneInstance = botCardScene.instantiate()
	newCloneInstance.fillInFromDict(cloneDict)
	return newCloneInstance


func selfAsDict():
	return {
		"label":label, 
		"sprite":sprite, 
		"description":description, 
		"baseHealth":baseHealth,
		"health":health, 
		"baseAttack":baseAttack,
		"attack":attack, 
		"attachPoints":attachPoints,
		"attach1":attach1,
		"attach2":attach2,
		"lineupPosition":lineupPosition
	}




func updateStatsWithParts():
	pass

#
#func getBaseStats():
	#return Vector2(attack, health)


func sayHi():
	print("hi from bot card")



func _exit_tree():
	print("=== == = botcard", label , " exiting the tree : ", $'.')
	pass



func takeHitEffect():
	pass
func sendAttackEffect():
	pass






