extends Area2D

signal fullClicked

@onready var startingScale = $'.'.scale

@onready var selectedScale = startingScale * Vector2(1.2, 1.2) #scale factor


var inDict
var inBot
var clickInitiated = false


func _ready():
	$'.'.input_event.connect(isClickedEvent)

func setInBot(inB:Bot):
	inBot = inB

func isClickedEvent(_vPort, eve, _shape):
	if eve is InputEventMouseButton:
		if eve.pressed:
			clickInitiated = true
		if clickInitiated and eve.pressed == false: # was initiated and let up
			clickInitiated = false
			fullClicked.emit()

func _mouse_exit():
	clickInitiated = false






func updateFromDict(dict:Dictionary):
	inDict = dict
	print("in taking dict is : ", dict)
	if inDict.has("label") and not inDict.sprite == null:
		%Label.text = inDict.label
	if inDict.has("description") and not inDict.sprite == null:
		%Description.text = inDict.description
	if inDict.has("sprite") and not inDict.sprite == null:
		var theSprite = load(inDict.sprite)
		%Sprite.texture = theSprite
	if inDict.has("baseHealth") and not inDict.sprite == null:
		%Health.text = "%s" % inDict.baseHealth
	if inDict.has("baseAttack") and not inDict.sprite == null:
		%Health.text = "%s" % inDict.baseAttack



func toDict():
	return inDict



func selected():
	print("card selected")
	var tween = create_tween()
	tween.tween_property($'.', "scale", selectedScale, Globals.config_cardSelectionTime)

func unselected():
	var tween = create_tween()
	tween.tween_property($'.', "scale", startingScale, Globals.config_cardSelectionTime)



