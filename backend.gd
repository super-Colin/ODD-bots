extends Node


#var botCardScene = preload("res://botCard.tscn")
var battleScene = preload("res://battle.tscn")
var cardChoiceScene = preload("res://card_choice.tscn")
var lineupEditScene = preload("res://lineup_edit.tscn")




func _ready():
	Events.game_start.connect(startGame)
	#Events.game_over.connect(gameOverReset)



func startGame():
	Globals.gameOver = false
	Globals.playerTeam = {}
	Globals.enemyTeam = {}
	var loopPhase=0
# ~~~~~ Start Game ~~~~~
	while not Globals.gameOver:
		await proccessGameplayLoopPhase(loopPhase) 
		loopPhase +=1

func proccessGameplayLoopPhase(loopPhase=0):
# ~~~~~ Player Bot Card Choice ~~~~~
	var newBotChoiceDict = await givePlayerBotChoice(3)
	#print("new bot addition is : ", newBotChoiceDict)
	Globals.playerTeam = Helper.team_addBot(Globals.playerTeam, newBotChoiceDict)
	#print("player team in phase ", loopPhase, ", team: ", Globals.playerTeam)
# ~~~~~ Player Edit Lineup ~~~~~
	var lineup = lineupEditScene.instantiate()
	lineup.setTeam(Globals.playerTeam)
	$'.'.add_child(lineup)
	Globals.playerTeam = await lineup.lineupConfirmed
	#print("player team after editing, ", Globals.playerTeam)
# ~~~~~ Create Enemy Lineup ~~~~~
	Globals.enemyTeam = assembleRandomTeam(loopPhase)
	#print("ENEMY team in phase ", loopPhase, ", team: ", Globals.enemyTeam)
# ~~~~~ Start Battle ~~~~~
	var battle = battleScene.instantiate()
	$'.'.add_child(battle)
	var playerWon = await battle.battleFinished
	print("battle is over")

	if playerWon:
		print("player won the battle, adding points")
		Events.game_updateSessionScore.emit(1)
		if Globals.sessionScore >= 2:
			Events.mode_gameWin.emit()
	else:
		Events.mode_gameOver.emit()
	battle.queue_free()
	return

func assembleRandomTeam(_numberOfBots = 1):
	var newTeam = {}
	for x in _numberOfBots+1:
		newTeam = Helper.team_addBot(newTeam, makeRandomBotDict())
	return newTeam


func givePlayerBotChoice(_choices=3):
	var botCardDicts = [makeRandomBotDict(), makeRandomBotDict(), makeRandomBotDict()]
	return await showCardChoice(botCardDicts)


func showCardChoice(cardOptions:Array):
	var newChoiceScene = cardChoiceScene.instantiate() # instantiate a new scene
	newChoiceScene.setCardChoices(cardOptions)
	%GameBits.add_child(newChoiceScene)
	var resultDict = await newChoiceScene.selection
	#print("choice result is ", resultDict)
	newChoiceScene.queue_free()
	#print("choice result after queueing is ", resultDict)
	return resultDict






func makeRandomBotDict(_parts=0):
	return Helper.bot_init(CardSet.cores.pick_random())
	









