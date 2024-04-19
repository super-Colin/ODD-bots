extends Node2D

signal lineupConfirmed

var cardScene = preload("res://card.tscn")


func _ready():
	Events.mode_editLineup.emit()
	fillLineup()


func fillLineup():
	print("team is ", Globals.playerTeam.team)
	for lineupPos in Globals.playerTeam.team:
		print("lineup pos is ", Globals.playerTeam.team[lineupPos])
		var newCard = cardScene.instantiate()
		newCard.fillFromDict(Globals.playerTeam.team[lineupPos])
		var pos = Vector2(300*lineupPos+300, 300)
		newCard.position = pos
		print("position is ", pos)
		$'.'.add_child(newCard)

func fillPositionFromDict(pos, dict):
	return

func swapPositions(pos1, pos2):
	var b1 = Globals.playerTeam[pos1] # move 1 to var
	Globals.playerTeam[pos1] = Globals.playerTeam[pos2] # move 2 to 1
	Globals.playerTeam[pos2] = b1 # move var to 2

func renderUpdate():
	pass




