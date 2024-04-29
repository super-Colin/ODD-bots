extends Node2D

signal battleFinished(playerWon:bool)

var cardScene = preload("res://card.tscn")

@onready var playerDisplayRectWidth = %PlayerDisplayArea/Area.shape.size.x
@onready var enemyDisplayRectWidth = %EnemyDisplayArea/Area.shape.size.x


var attack_started = false;

@onready var playerTeamCopy = Globals.playerTeam
@onready var enemyTeamCopy = Globals.enemyTeam

func _ready():
	Events.mode_gameOver.connect(func (): $'.'.queue_free())
	Events.mode_gameWin.connect(func (): $'.'.queue_free())
	Events.mode_battle.emit()
	renderTeam(playerTeamCopy)
	renderTeam(enemyTeamCopy, false)
	playOutBattle()



func renderTeam(team, isPlayer=true):
	for lineupPos in team:
		#if lineupPos == 0:
			#lineupPos += 1
		#print("rendering team, position: ", lineupPos)
		var botDict = team[lineupPos]
		#print("lineup pos is ", botDict)
		var newCard = cardScene.instantiate()
		newCard.updateFromDict(botDict)
		team[lineupPos].cardRef = newCard
		var pos
		if isPlayer:
			#pos = Vector2(playerDisplayRectWidth - (300*lineupPos), 300)
			pos = Vector2( (playerDisplayRectWidth / 3) * lineupPos, 0)
		else:
			#pos = Vector2(enemyDisplayRectWidth + ((enemyDisplayRectWidth / 3) *lineupPos), 300)
			pos = Vector2((enemyDisplayRectWidth / 3) * -lineupPos, 0)
		newCard.position = pos
		if isPlayer:
			$PlayerDisplayArea/Area.add_child(newCard)
		else:
			$EnemyDisplayArea/Area.add_child(newCard)
		#print("position is ", pos)

func sendUpdatesToCards():
	for lineupPos in playerTeamCopy:
		print("updating ", lineupPos, " in player team")
		playerTeamCopy[lineupPos].cardRef.updateFromDict(playerTeamCopy[lineupPos])
	for lineupPos in enemyTeamCopy:
		#print("updating ", lineupPos, " in enemy team")
		enemyTeamCopy[lineupPos].cardRef.updateFromDict(enemyTeamCopy[lineupPos])





func playOutBattle():
	var battleOver = false
	var loopNum = 0
	while not battleOver:
		print("starting timer")
		await get_tree().create_timer(1.5).timeout # wait for 1 second
		print("timer done")
		var playerAttack = Helper.team_getDamage(playerTeamCopy)
		var enemyAttack = Helper.team_getDamage(enemyTeamCopy)
		#print("playerAttack is: ", playerAttack)
		print("player team before attack: ", playerTeamCopy)
		playerTeamCopy = Helper.team_takeAttack(playerTeamCopy, enemyAttack)
		enemyTeamCopy = Helper.team_takeAttack(enemyTeamCopy, playerAttack)
		print("player team after attack: ", playerTeamCopy)
		#print("enemy team after attack: ", enemyTeamCopy)
		sendUpdatesToCards()
		print("starting timer")
		await get_tree().create_timer(1.5).timeout # wait for 1 second
		print("timer done")
		#if Globals.enemyTeam.isDefeated():
		if Helper.team_isDefeated(enemyTeamCopy):
			battleOver = true
			print("player is the winner")
			battleFinished.emit(true)
			$'.'.queue_free()
		if Helper.team_isDefeated(playerTeamCopy):
			battleOver = true
			battleFinished.emit(false)
			print("enemy is the winner")
			Events.game_over.emit()
			Events.mode_gameOver.emit()
			$'.'.queue_free()
		loopNum += 1
		print("battle loop number : ", loopNum)
		
	print("battle played out")






