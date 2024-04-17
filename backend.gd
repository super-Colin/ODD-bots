extends Node

var battleScene = preload("res://battle.tscn")
var botCardScene = preload("res://botCard.tscn")
var cardChoiceScene = preload("res://card_choice.tscn")
var lineupEditScene = preload("res://lineup_edit.tscn")


var enemyTeam
var enemyLineup
var battleFramePhase = 0
var ongoingBattle

var gameplayLoopPhase= 0
var gameOver = false



# Called when the node enters the scene tree for the first time.
func _ready():
	Events.game_start.connect(startGame)
	%DebugPlayerTeam.pressed.connect(debugPlayerTeam)
	Events.game_over.connect(gameOverReset)
	Events.debug_message.emit(showDebugMessage)




func startGame():
	gameOver = false
	while not gameOver:
		await proccessGameplayLoopPhase()


func proccessGameplayLoopPhase():
# ~~~~~ Start Game ~~~~~
	if gameplayLoopPhase == 0:
# ~~~~~ Create player team and select first bot ~~~~~
		#var newBotChoiceDict = await givePlayerBotChoiceDict()
		#GlobalsDict.addBotToTeamFromDict(newBotChoiceDict)
		Globals.playerTeam = Team.new()
		
		var newBotChoice = await givePlayerBotChoice()
		Globals.playerTeam.addBotToTeam(newBotChoice)
		Globals.playerLineup = Globals.playerTeam.getLineup()
		print("new bot addition is : ", newBotChoice)
		print("playerlineup dict is now : ", Globals.playerLineupDict)
		gameplayLoopPhase += 1
	else:
# ~~~~~ Player select a bot to add to team ~~~~~
		var coreOptions = [makeRandomBot(), makeRandomBot(), makeRandomBot()]
		var choice = await showChoice(coreOptions)
		Globals.playerTeam.addBotToTeam(choice)
	print("player team in phase ", gameplayLoopPhase, " , team: ", Globals.playerTeam)
# ~~~~~ Player edit lineup ~~~~~
	Events.game_editLineupMode.emit()
	await showLineupEdit() # using global team
	#print("player team after editing, ", Globals.playerLineup)
# ~~~~~ Create enemy lineup ~~~~~
	enemyTeam = assembleRandomTeam(gameplayLoopPhase)

# ~~~~~ Start the battle ~~~~~
	ongoingBattle = battleScene.instantiate()
	$'GameBits'.add_child(ongoingBattle)
	#ongoingBattle.startNewBattleFromLineups(enemyTeam.getLineup())
	Globals.enemyLineup = enemyTeam.getLineup()
	ongoingBattle.startNewBattleFromLineups()
	#ongoingBattle.startBattle()
	Events.game_battleMode.emit()
	await ongoingBattle.playerConfirmedBattleIsOver
	print("battle result winning team '", ongoingBattle.winningTeam, "'")
	if ongoingBattle.winningTeam == "enemy" or ongoingBattle.winningTeam == "team2":
		gameOverReset()
		Events.game_over.emit()
		return
	if ongoingBattle.winningTeam == "player" or ongoingBattle.winningTeam == "team1" :
		#print("emiting updated score")
		Events.game_updateScoreBackend.emit(Globals.sessionScore + 1)
	clearBattle()
	Events.game_editLineupMode.emit()
## ~~~~~ If you lost reset the state ~~~~~
## ~~~~~ If you won, pick another bot and continue ~~~~~






func assembleRandomTeam(size=1, partsPer=0):
	var newTeam = Team.new()
	for x in size:
		newTeam.addBotToTeam( makeRandomBot(partsPer) )
	return newTeam

func assembleEnemyLineup(team):
	if not enemyTeam and team:
		enemyTeam = team
	#print("assembling enemy lineup from team: ", enemyTeam)
	var lineup = enemyTeam.getTeam()
	for linupPosition in lineup:
		var botCard = lineup[linupPosition]
		botCard.position = Vector2(200*linupPosition + 50, 300)
	#print("assembled enemy lineup: ", team)
	return team










func gameOverReset():
	print("GAME OVER RESET")
	clearBattle()
	Events.game_mainMenuMode.emit()
	gameplayLoopPhase = 0
	gameOver = true



func showLineupEdit():
	var newLineupEditScene = lineupEditScene.instantiate()
	$'GameBits'.add_child(newLineupEditScene)
	var result = await newLineupEditScene.linupConfirmed # should be a clone team
	#print("lineup edit results are, ",result)
	return result




func clearBattle():
	#print("current backend team : ", Globals.playerTeam)
	#print("current backend lineup : ", Globals.	playerLineup)
	if ongoingBattle:
		#print("ended battle team : ", ongoingBattle.team1)
		#print("ended battle lineup : ", ongoingBattle.team1Lineup)
		ongoingBattle.queue_free()
		pass
	battleFramePhase = 0
	ongoingBattle = null


func givePlayerBotChoiceDict(_choices=3):
	var botOptions = [makeRandomBot(), makeRandomBot(), makeRandomBot()]
	var choiceDict = await showChoice(botOptions)
	return choiceDict


func showChoiceDict(options):
	var newChoice = cardChoiceScene.instantiate()
	newChoice.fillChoices(options)
	$'GameBits'.add_child(newChoice)
	var resultDict = await newChoice.choiceConfirmed
	#print("show choice returning: ", resultDict)
	return resultDict





func givePlayerBotChoice(_choices=3):
	var botOptions = [makeRandomBot(), makeRandomBot(), makeRandomBot()]
	var choiceDict = await showChoiceDict(botOptions)
	return choiceDict


func showChoice(options):
	var newChoice = cardChoiceScene.instantiate()
	newChoice.fillChoices(options)
	$'GameBits'.add_child(newChoice)
	var resultDict = await newChoice.choiceConfirmed
	#print("show choice returning: ", resultDict)
	return resultDict


func makeRandomBot(_parts=0):
	var stats = CardSet.cores.pick_random()
	#print(randBot)
	var randBot = botCardScene.instantiate()
	randBot.fillInFromDict(stats)
	#print("makeRandomBot returning: ", randBot)
	return randBot
	









func debugPlayerTeam():
	var current = %DebugPlayerTeam.get_children()
	for x in current:
		x.queue_free()
	if not Globals.playerTeam:
		print("no player team")
		return
	var team = Globals.playerTeam.getTeamClone()
	for linupPosition in team:
		var botCard = team[linupPosition]
		botCard.position = Vector2(50*linupPosition + 1200, 200*linupPosition + 100)
		%DebugPlayerTeam.add_child(botCard)



func showDebugMessage(msg):
	%DebugMessage.text = msg
	await get_tree().create_timer(2.0).timeout
	%DebugMessage.text = ""








