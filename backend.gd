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
	var loopPhase=0
	while not Globals.gameOver:
		await proccessGameplayLoopPhase(loopPhase) # TODO move this while loop into the function?
		loopPhase +=1



func proccessGameplayLoopPhase(loopPhase=0):
# ~~~~~ Start Game ~~~~~
	if loopPhase == 0:
# ~~~~~ Create Player Team ~~~~~
		Globals.playerTeam = Team.new()
# ~~~~~ Player Bot Card Choice ~~~~~
	var newBotChoiceDict = await givePlayerBotChoice(3)
	#print("new bot addition is : ", newBotChoiceDict)
	Globals.playerTeam.addBotToLineup(newBotChoiceDict)
	#print("player team in phase ", loopPhase, ", team: ", Globals.playerTeam)
# ~~~~~ Player Edit Lineup ~~~~~
	var lineup = lineupEditScene.instantiate()
	$'.'.add_child(lineup)
	await lineup.lineupConfirmed
	#print("player team after editing, ", Globals.playerLineup)
# ~~~~~ Create Enemy Lineup ~~~~~
	assembleRandomTeam(loopPhase)
	#print("ENEMY team in phase ", loopPhase, ", team: ", Globals.enemyTeam)
# ~~~~~ Start Battle ~~~~~
	var battle = battleScene.instantiate()
	$'.'.add_child(battle)
	var playerWon = await battle.battleFinished
	if playerWon:
		print("player won the battle")
		Globals.sessionScore += 1
	else:
		Events.mode_gameOver.emit()
	battle.queue_free()
	return

func assembleRandomTeam(_numberOfBots = 1):
	Globals.enemyTeam = Team.new()
	Globals.enemyTeam.addBotToLineup(makeRandomBotDict())


func givePlayerBotChoice(_choices=3):
	var botCardDicts = [makeRandomBotDict(), makeRandomBotDict(), makeRandomBotDict()]
	return await showCardChoice(botCardDicts)


func showCardChoice(cardOptions:Array):
	var newChoiceScene = cardChoiceScene.instantiate() # instantiate a new scene
	newChoiceScene.setCardChoices(cardOptions)
	%GameBits.add_child(newChoiceScene)
	var resultDict = await newChoiceScene.selection
	#print("choice result is ", resultDict)
	resultDict = resultDict.toDict()
	newChoiceScene.queue_free()
	#print("choice result after queueing is ", resultDict)
	return resultDict






func makeRandomBotDict(_parts=0):
	var statsDict = CardSet.cores.pick_random()
	#print(randBot)
	#var randBot = botCardScene.instantiate()
	#randBot.fillInFromDict(stats) 
	#print("makeRandomBot returning: ", randBot)
	return statsDict
	









