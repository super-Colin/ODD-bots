extends Node2D


signal selection(theChoice)


var cardScene = preload("res://card.tscn")
 
var inChoices
var choiceInstances = []
var lastSelection


func _ready():
	var tween = create_tween()
	tween.tween_property($ColorRect, "Color", 363636e2, Globals.config_sceneTransitionTime) 
	$ConfirmSelection.pressed.connect(confirmedSelection)


func confirmedSelection():
	var tween = create_tween()
	await tween.tween_property($ColorRect, "Color", 36363600, Globals.config_sceneTransitionTime) 
	selection.emit(lastSelection.toDict())





func setCardChoices(choices:Array):
	inChoices = choices
	#print("choices ", choices)
	var cardNum = 0
	for choiceDict in choices:
		var newCard = cardScene.instantiate()
		newCard.fillFromDict(choiceDict)
		var pos = Vector2(300*cardNum+300, 300)
		newCard.position = pos
		print("position is ", pos)
		$'.'.add_child(newCard)
		connectSignalsFromCard(newCard)
		choiceInstances.push_back(newCard)
		cardNum += 1


func connectSignalsFromCard(cardInstance):
	# update the card to return to the last card selected
	cardInstance.fullClicked.connect(func():lastSelection = cardInstance)
	# select this card and delselect other cards
	cardInstance.fullClicked.connect(func(): cardInstance.selected())
	cardInstance.fullClicked.connect(deselectOtherCards)

func deselectOtherCards():
	for cInstance in choiceInstances:
		if not cInstance == lastSelection:
			cInstance.unselected()






