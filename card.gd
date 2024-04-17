extends Area2D

signal fullClicked

@onready var startingScale = $'.'.scale

@onready var selectedScale = startingScale * Vector2(1.2, 1.2) #scale factor


var inDict
var clickInitiated = false


func _ready():
	$'.'.input_event.connect(isClickedEvent)


func selected():
	print("card selected")
	var tween = create_tween()
	tween.tween_property($'.', "scale", selectedScale, Globals.config_cardSelectionTime)

func unselected():
	var tween = create_tween()
	tween.tween_property($'.', "scale", startingScale, Globals.config_cardSelectionTime)



func isClickedEvent(_vPort, eve, _shape):
	#print(eve)
	if eve is InputEventMouseButton:
		if eve.pressed:
			clickInitiated = true
		if clickInitiated and eve.pressed == false: # was initiated and let up
			clickInitiated = false
			#print("full clicked")
			fullClicked.emit()

func _mouse_exit():
	clickInitiated = false






func fillFromDict(dict:Dictionary):
	inDict = dict
	print("in taking dict is : ", dict)
	%Label.text = inDict.label
	%Description.text = inDict.description
	if inDict.has("sprite") and not inDict.sprite == null:
		var spriteIs = load(inDict.sprite)
		%Sprite.texture = spriteIs
	if inDict.has("baseHealth"):
		%Health.text = "%s" % inDict.baseHealth
	if inDict.has("baseAttack"):
		%Health.text = "%s" % inDict.baseAttack



func toDict():
	return inDict









