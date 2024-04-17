
class_name Battle extends Node2D

var botCardScene = preload("res://botCard.tscn")

signal playerConfirmedBattleIsOver


var team1
var team1Lineup
var team2
var team2Lineup
var team1Cards = []
var team2Cards = []

var initialRenderDone = false

var lineup1
var lineup2

var winningTeam
var losingTeam
var isTie = false




func _init():
	Events.battle_render.connect(renderBattleLineup)
	#Events.battle_start.connect(startBattle)
	Events.battle_nextFrame.connect(processBattleFrame)



func startNewBattle():
	$EndBattleButton.pressed.connect(emitBattleIsOverSignals)
	if not initialRenderDone:
		renderBattle()
		initialRenderDone = true
	runFramesUntilWipe()

func emitBattleIsOverSignals():
	$'.'.playerConfirmedBattleIsOver.emit()
	#Events.game_editLineupMode.emit()



func startNewBattleFromLineups():
	$EndBattleButton.pressed.connect(func():$'.'.playerConfirmedBattleIsOver.emit())
	setLineup1(Globals.playerTeam.getLineup())
	#setLineup1(Globals.playerLineup)
	setLineup2(Globals.enemyLineup)
	print(" --- Battle Starting ---")
	#print("team1 : ",team1)
	#print("team2 : ",enemyLineup)
	#print("team1Lineup : ",team1Lineup)
	print("team2Lineup : ",Globals.enemyLineup)
	if not initialRenderDone:
		renderBattleLineup()
	#print(" --- Battle rendered... ---")
	#print("team lineups: ", team1Lineup, "   -    ",  enemyLineup)
	print("running until wipe")
	runFramesUntilWipe()
	#print("team lineups: ", team1Lineup, "   -    ",  enemyLineup)


func runFramesUntilWipe():
	var battleStillGoing = true
	while battleStillGoing:
		#print("=== === running battleframe ", frame)
		#print("Lineups: ", team1Lineup, "   -    ",  team2Lineup)
		battleStillGoing = processBattleFrame()
		await get_tree().create_timer(0.5).timeout
		#print(" --- FINISHED battle frame ",frame," ---")
	if winningTeam == "player":
		$'BattleResultText'.text = "You Win!"
	if winningTeam == "team2":
		$'BattleResultText'.text = "You Lost :("
	if isTie:
		$'BattleResultText'.text = "Draw"
	$'BattleResultText'.visible = true
	return




func processBattleFrame():
	#print(" --- Next battle frame! ---")
	#print("processBattleFrame team lineups: ", team1Lineup, "   -    ",  team2Lineup)
	#print("processBattleFrame frontline: ", team1[1], "   -    ",  team2[1])
	#var team1Outgoing = team1Lineup[1].outgoingAttack()
	#var team2Outgoing = team2Lineup[1].outgoingAttack()
	var team1Outgoing = Globals.playerLineup[1].outgoingAttack()
	var team2Outgoing = Globals.enemyLineup[1].outgoingAttack()
	#print("Outgoing attacks: ", team1Outgoing, "   -    ",  team2Outgoing)
	var t1Alive = team1Lineup[1].takeIncomingAttacks(team2Outgoing)
	#team1Lineup[1].shakeEffect()
	var t2Alive = team2Lineup[1].takeIncomingAttacks(team1Outgoing)
	updateTeamCardFaces()
	#print("processBattleFrame team lineups after incoming attacks: ", team1Lineup, "   -    ",  team2Lineup)
	if t1Alive and not t2Alive:
		winningTeam = "player"
		print("player wins")
		#Events.game_updateScoreBackend.emit(Globals.sessionScore + 1)
		return false
	if t2Alive and not t1Alive:
		winningTeam = "team2"
		#print("team2 wins")
		return false
	if not t1Alive and not t2Alive:
		winningTeam = "tie"
		isTie = true
		return false
	return true # battle still going









func renderBattle():
	#print(" --- Battle Rendering ---")
	#print("Rendering left: ", team1)
	renderTeam(team1, "left")
	#print("Rendering right: ", team2)
	renderTeam(team2, "right")


func renderBattleLineup():
	#print(" --- Battle Rendering from lineup ---")
	#print("Rendering left: ", team1Lineup)
	renderLineup(team1Lineup, "left")
	#print("Rendering right: ", team2Lineup)
	renderLineup(team2Lineup, "right")




func renderTeam(team, side):
	#print("renderTeam runnning")
	#team = team.getTeam()
	for linupPosition in team:
		var botCard = team[linupPosition].cloneSelf()
		if side == "left":
			botCard.position = Vector2(200*linupPosition + 150, 300)
			team1Cards.push_back(botCard)
		else:
			botCard.position = Vector2(1400 -(200*linupPosition), 300)
			team2Cards.push_back(botCard)
		$'.'.add_child(botCard)



func renderLineup(lineup, side):
	print("renderLineup runnning : ", lineup )
	for linupPosition in lineup:
		var botCard = lineup[linupPosition].cloneSelf()
		if side == "left":
			botCard.position = Vector2(200*linupPosition + 150, 300)
			team1Cards.push_back(botCard)
		else:
			botCard.position = Vector2(1400 -(200*linupPosition), 300)
			team2Cards.push_back(botCard)
		$'.'.add_child(botCard)




func setTeam2(team):
	#print("setting team2 ", team)
	team2 = team
	team2Lineup = team.getLineup()

func setLineup1(lineup):
	#print("setting team1 lineup", lineup)
	team1Lineup = lineup

func setLineup2(lineup):
	#print("setting team2 lineup ", lineup)
	team2Lineup = lineup


func updateTeamCardFaces():
	#TODO
	for c in team1Lineup:
		team1Lineup[c].updateFace()
	for c in team2Lineup:
		team2Lineup[c].updateFace()
	pass








