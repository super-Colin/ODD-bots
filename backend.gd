extends Node


#var botCardScene = preload("res://botCard.tscn")
#var battleScene = preload("res://battle.tscn")
var cardChoiceScene = preload("res://card_choice.tscn")
#var lineupEditScene = preload("res://lineup_edit.tscn")









func _ready():
	Events.game_start.connect(startGame)



func startGame():
	Globals.gameOver = false
	var loopPhase=0
	while not Globals.gameOver:
		await proccessGameplayLoopPhase(loopPhase)
		loopPhase +=1



func proccessGameplayLoopPhase(loopPhase=0):
# ~~~~~ Start Game ~~~~~
	if loopPhase == 0:
# ~~~~~ Create player team and select first bot ~~~~~
		Globals.playerTeam = Team.new()
	var newBotChoiceDict = await givePlayerBotChoice(3)
	Globals.playerTeam.addBotToTeam(newBotChoiceDict)
	print("new bot addition is : ", newBotChoiceDict)
	#print("player team in phase ", gameplayLoopPhase, ", team: ", Globals.playerTeam)
# ~~~~~ Player edit lineup ~~~~~
	Events.mode_editLineup.emit()
	await showLineupEdit() # using global team
	Globals.mode_gameOver.emit()
	#print("player team after editing, ", Globals.playerLineup)
# ~~~~~ Create enemy lineup ~~~~~
	#enemyTeam = assembleRandomTeam(gameplayLoopPhase)
#
## ~~~~~ Start the battle ~~~~~
	#ongoingBattle = battleScene.instantiate()
	#$'GameBits'.add_child(ongoingBattle)
	##ongoingBattle.startNewBattleFromLineups(enemyTeam.getLineup())
	#Globals.enemyLineup = enemyTeam.getLineup()
	#ongoingBattle.startNewBattleFromLineups()
	##ongoingBattle.startBattle()
	#Events.game_battleMode.emit()
	#await ongoingBattle.playerConfirmedBattleIsOver
	#print("battle result winning team '", ongoingBattle.winningTeam, "'")
	#if ongoingBattle.winningTeam == "enemy" or ongoingBattle.winningTeam == "team2":
		#gameOverReset()
		#Events.game_over.emit()
		#return
	#if ongoingBattle.winningTeam == "player" or ongoingBattle.winningTeam == "team1" :
		##print("emiting updated score")
		#Events.game_updateScoreBackend.emit(Globals.sessionScore + 1)
	#clearBattle()
	#Events.game_editLineupMode.emit()
### ~~~~~ If you lost reset the state ~~~~~
### ~~~~~ If you won, pick another bot and continue ~~~~~




func givePlayerBotChoice(_choices=3):
	var botCardDicts = [makeRandomBotDict(), makeRandomBotDict(), makeRandomBotDict()]
	return await showCardChoice(botCardDicts)
	#return choiceDict


func showCardChoice(cardOptions:Array):
	# instantiate a new scene
	var newChoiceScene = cardChoiceScene.instantiate()
	newChoiceScene.setCardChoices(cardOptions)
	%GameBits.add_child(newChoiceScene)
	var resultDict = await newChoiceScene.selection
	print("choice result is ", resultDict)
	return resultDict


func showLineupEdit():
	return




func makeRandomBotDict(parts=0):
	var statsDict = CardSet.cores.pick_random()
	#print(randBot)
	#var randBot = botCardScene.instantiate()
	#randBot.fillInFromDict(stats) 
	#print("makeRandomBot returning: ", randBot)
	return statsDict
	











