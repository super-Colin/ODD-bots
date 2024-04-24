extends Node2D

signal battleFinished(playerWon)

var cardScene = preload("res://card.tscn")

@onready var playerDisplayRectWidth = %PlayerDisplayArea/Area.shape.size.x
@onready var enemyDisplayRectWidth = %EnemyDisplayArea/Area.shape.size.x



func _ready():
	playOutBattle()


func playOutBattle():
	pass



func processFrame():
	#initial render
	renderFrame()
	# deal out damage
#...


func renderFrame():
	renderPLayerTeam()
	renderEnemyTeam()


func renderPLayerTeam():
	print("fillLineup team is ", Globals.playerTeam.team)
	for lineupPos in Globals.playerTeam.team:
		print("lineup pos is ", Globals.playerTeam.team[lineupPos])
		var newCard = cardScene.instantiate()
		newCard.updateFromDict(Globals.playerTeam.team[lineupPos])
		var pos = Vector2(playerDisplayRectWidth - (300*lineupPos), 300)
		newCard.position = pos
		$'.'.add_child(newCard)
		print("position is ", pos)


func renderEnemyTeam():
	print("fillLineup team is ", Globals.playerTeam.team)
	for lineupPos in Globals.playerTeam.team:
		print("lineup pos is ", Globals.playerTeam.team[lineupPos])
		var newCard = cardScene.instantiate()
		newCard.updateFromDict(Globals.playerTeam.team[lineupPos])
		var pos = Vector2(enemyDisplayRectWidth - (300*lineupPos), 300)
		newCard.position = pos
		$'.'.add_child(newCard)
		print("position is ", pos)











