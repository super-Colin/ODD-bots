extends Node2D


signal selection(theChoice)


var cardScene = preload("res://card.tscn")
 
var inChoices
var choiceInstances = []
var lastSelection


func _ready():
	Events.mode_gameOver.connect(func (): $'.'.queue_free())
	Events.mode_gameWin.connect(func (): $'.'.queue_free())
	Events.mode_cardChoice.emit()
	var tween = create_tween()
	tween.tween_property($ColorRect, "color", Color("363636e2"), Globals.conf_sceneTransitionTime) 
	$ConfirmSelection.pressed.connect(confirmedSelection)


func confirmedSelection():
	if lastSelection:
		var tween = create_tween()
		tween.tween_property($ColorRect, "color", Color("36363600"), Globals.conf_sceneTransitionTime) 
		selection.emit(lastSelection.toDict())





func setCardChoices(choices:Array):
	inChoices = choices
	#print("choices ", choices)
	var cardNum = 0
	for choiceDict in choices:
		var newCard = cardScene.instantiate()
		newCard.updateFromDict(choiceDict)
		var pos = Vector2(300*cardNum+300, 300)
		newCard.position = pos
		#print("position is ", pos)
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






