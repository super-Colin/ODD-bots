extends Node2D

signal choiceConfirmed(selection)

var cardChoices
var selectedChoice
var bgClickInitiated = false


func _ready():
	$Area2D.input_event.connect(bgFullClicked)
	%ConfirmChoice.pressed.connect(confirmChoice)



func fillChoices(cards):
	var totalChoices = cards.size()
	var totalSpace = 1000
	var spacing = totalSpace / totalChoices
	var i = 0
	for c in cards:
		c.position = Vector2(spacing*i + 100, 500)
		#c.h
		c.fullClicked.connect(selectChoice)
		$'.'.add_child(c)
		i += 1



func selectChoice(cardNode):
	if selectedChoice:
		unselectSelected()
	selectedChoice = cardNode
	cardNode.select()
	#print("selected card")


func unselectSelected():
	if selectedChoice:
		selectedChoice.unselect()
		selectedChoice = null



func confirmChoice():
	if not selectedChoice:
		return null
	selectedChoice.duplicate()
	choiceConfirmed.emit(selectedChoice.cloneSelf())
	$'.'.queue_free()



func bgFullClicked(_vPort, eve, _shape):
	if eve is InputEventMouseButton:
		if eve.pressed:
			bgClickInitiated = true
		if bgClickInitiated and eve.pressed == false:
			bgClickInitiated = false
			unselectSelected()
			#print("bg unselected card")




