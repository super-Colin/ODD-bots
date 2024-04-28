extends Node2D

signal battleFinished(playerWon:bool)

var cardScene = preload("res://card.tscn")

@onready var playerDisplayRectWidth = %PlayerDisplayArea/Area.shape.size.x
@onready var enemyDisplayRectWidth = %EnemyDisplayArea/Area.shape.size.x


var attack_started = false;


func _ready():
	playOutBattle()


func playOutBattle():
	var playerWon = null
	while playerWon == null:
		#print('playerWon is null')
		if attack_started:
			print("Not attacking, attack code running in background")
			return
		else:
			attack_started = true
			renderPLayerTeam()
			renderEnemyTeam()
			var playerAttack = Globals.playerTeam.getTeamDamage()
			var enemyAttack = Globals.enemyTeam.getTeamDamage()
			print("playerAttack is: ", playerAttack)
			print("enemyAttack is: ", enemyAttack)
			Globals.enemyTeam.takeAttack(playerAttack)
			Globals.playerTeam.takeAttack(enemyAttack)

			attack_started = false
			if Globals.enemyTeam.isDefeated():
				playerWon = true
				print("player won the battle")
				battleFinished.emit(playerWon)
			if Globals.playerTeam.isDefeated():
				battleFinished.emit(false)
				Events.game_over.emit()
			await get_tree().create_timer(0.5).timeout # wait for 1 second



func processFrame():
	#initial render
	renderFrame()
	# deal out damage
#...


func renderFrame():
	renderPLayerTeam()
	renderEnemyTeam()


func renderPLayerTeam():
	print("fillLineup team is ", Globals.playerTeam.getTeam())
	for lineupPos in Globals.playerTeam.team:
		print("lineup pos is ", Globals.playerTeam.team[lineupPos])
		var newCard = cardScene.instantiate()
		newCard.updateFromDict(Globals.playerTeam.team[lineupPos].toDict())
		var pos = Vector2(playerDisplayRectWidth - (300*lineupPos), 300)
		newCard.position = pos
		$'.'.add_child(newCard)
		print("position is ", pos)


func renderEnemyTeam():
	print("fillLineup team is ", Globals.playerTeam.team)
	for lineupPos in Globals.playerTeam.team:
		print("lineup pos is ", Globals.playerTeam.team[lineupPos])
		var newCard = cardScene.instantiate()
		newCard.updateFromDict(Globals.playerTeam.team[lineupPos].toDict())
		var pos = Vector2(enemyDisplayRectWidth + ((enemyDisplayRectWidth / 3) *lineupPos), 300)
		newCard.position = pos
		$'.'.add_child(newCard)
		print("position is ", pos)











