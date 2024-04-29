extends Node2D

signal lineupConfirmed(newLineup:Dictionary)

var cardScene = preload("res://card.tscn")

@onready var displayRectWidth = %DisplayArea/Area.shape.size.x
#@onready var teamCopy = Globals.playerTeam.getTeamCopy()
var team


func _ready():
	Events.mode_gameOver.connect(func (): $'.'.queue_free())
	Events.mode_gameWin.connect(func (): $'.'.queue_free())
	Events.mode_editLineup.emit()
	#print("rect width is ", displayRectWidth)
	%Confirm.pressed.connect(_updateConfirmed)
	fillLineup()

func setTeam(_team: Dictionary):
	team = _team

func fillLineup():
	for lineupPos in team:
		#print("lineup pos is ", Globals.playerTeam.team[lineupPos])
		var newCard = cardScene.instantiate()
		newCard.updateFromDict(team[lineupPos])
		newCard.position = Vector2(displayRectWidth - (300*lineupPos), 300)
		$'.'.add_child(newCard)


func swapPositions(team, pos1, pos2):
	var b1 = team[pos1] # move 1 to var
	team[pos1] = team[pos2] # move 2 to 1
	team[pos2] = b1 # move var to 2

func renderUpdate():
	pass


func _updateConfirmed():
	lineupConfirmed.emit(team)
	$'.'.queue_free()



func game_over():
	$'.'.queue_free()




