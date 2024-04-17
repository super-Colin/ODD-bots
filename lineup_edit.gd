extends Node2D

signal linupConfirmed()

var lineup

# Called when the node enters the scene tree for the first time.
func _ready():
	%ConfirmChoice.pressed.connect(confirmLineup)
	renderLineup()






func renderLineup():
	print("lineup editor rendering global team: ", Globals.playerTeam.getLineup())
	#print(" global team is in tree: ", Globals.playerTeam.is_inside_tree())
	var globalPlayerLineup = Globals.playerTeam.getLineup()
	for linupPosition in globalPlayerLineup:
		#var botCard = Globals.playerLineup[linupPosition]
		var botCard = globalPlayerLineup[linupPosition]
		botCard.position = Vector2(200*linupPosition + 50, 300)
		$'.'.add_child(botCard)
	

func renderAvailableParts():
	pass



func confirmLineup():
	linupConfirmed.emit()
	$'.'.queue_free()
