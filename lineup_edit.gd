extends Node2D

signal lineupConfirmed

var cardScene = preload("res://card.tscn")

@onready var displayRectWidth = %DisplayArea/Area.shape.size.x
#@onready var displayRectWidth = %DisplayArea/Area.shape.size.x
@onready var teamCopy = Globals.playerTeam.getTeamCopy()


func _ready():
	#print("rect width is ", displayRectWidth)
	Events.mode_editLineup.emit()
	%Confirm.pressed.connect(_updateConfirmed)
	fillLineup()


func fillLineup():
	#print("fillLineup team is ", Globals.playerTeam.team)
	for lineupPos in teamCopy.team:
		var bot = teamCopy.getBot(lineupPos)
		#print("lineup pos is ", Globals.playerTeam.team[lineupPos])
		var newCard = cardScene.instantiate()
		newCard.updateFromDict(bot.toDict())
		var pos = Vector2(displayRectWidth - (300*lineupPos), 300)
		newCard.position = pos
		$'.'.add_child(newCard)
		#print("position is ", pos)


func swapPositions(pos1, pos2):
	var b1 = teamCopy[pos1] # move 1 to var
	teamCopy[pos1] = teamCopy[pos2] # move 2 to 1
	teamCopy[pos2] = b1 # move var to 2

func renderUpdate():
	pass


func _updateConfirmed():
	lineupConfirmed.emit()
	$'.'.queue_free()



func game_over():
	$'.'.queue_free()




