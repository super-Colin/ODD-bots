extends Area2D

signal fullClicked

@onready var startingScale = $'.'.scale

@onready var selectedScale = startingScale * Vector2(1.2, 1.2) #scale factor


var inDict
var clickInitiated = false

var currentHealth = null

func _ready():
	$'.'.input_event.connect(isClickedEvent)


func isClickedEvent(_vPort, eve, _shape):
	if eve is InputEventMouseButton:
		if eve.pressed:
			clickInitiated = true
		if clickInitiated and eve.pressed == false: # was initiated and let up
			clickInitiated = false
			fullClicked.emit()

func _mouse_exit():
	clickInitiated = false






func updateFromDict(cardDict:Dictionary):
	inDict = cardDict
	#print("in taking dict is : ", dict)
	#print("updating card face")
	if cardDict.has("label"):
		%Label.text = cardDict.label
	if cardDict.has("description"):
		%Description.text = cardDict.description
	if cardDict.has("sprite") and not cardDict.sprite == null:
		var theSprite = load(cardDict.sprite)
		%Sprite.texture = theSprite
	if cardDict.has("remainingHealth"):
		if currentHealth != null and currentHealth > inDict.remainingHealth:
			print("card hit")
			hitEffect()
		currentHealth = cardDict.remainingHealth
		%Health.text = "%s" % currentHealth
	if cardDict.has("totalAttack"):
		%Attack.text = "%s" % cardDict.totalAttack



func toDict():
	return inDict



func selected():
	#print("card selected")
	var tween = create_tween()
	tween.tween_property($'.', "scale", selectedScale, Globals.conf_cardSelectionTime)

func unselected():
	var tween = create_tween()
	tween.tween_property($'.', "scale", startingScale, Globals.conf_cardSelectionTime)

func hitEffect():
	var tween = create_tween()
	await tween.tween_property($'.', "rotation", -0.1, 0.1)
	tween.tween_property($'.', "rotation", 0, 0.5)




