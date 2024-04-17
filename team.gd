
class_name Team extends Node2D


var botCards = {
	#"1":{botCard} -> getStats() : { "attack":1, ... 
}
var lineup = {}

func setLineup(_lineup):
	lineup = _lineup






func selfAsDict():
	pass





func getOutgoingAttacks():
	return lineup["1"].outgoingAttack()

func takeIncomingAttacks(incomingAttacks):
	for atk in incomingAttacks:
		botCards[atk.toPosition].takeDamage(atk.damage)
		# TODO update card faces 
	var teamWipe = true
	for b in botCards:
		if not botCards[b].dead:
			teamWipe = false
			break
	if teamWipe:
		pass
		#Events









func addBotToTeam(bot):
	botCards[botCards.size()+1] = bot
	


func moveBotInTeam(_botPosition, _moveToPosistion):
	pass

func getTeam():
	var cloneTeam = {}
	# TODO this will fuck up positioning later....
	#if lineup:
		#return lineup
	for b in botCards:
		var botCard = botCards[b].cloneSelf()
		cloneTeam[b] = botCard
	return cloneTeam

func getLineup():
	var cloneLineup = {}
	for b in botCards:
		var botCard = botCards[b].cloneSelf()
		if botCards[b].lineupPosition:
			pass
		cloneLineup[b] = botCard
	return cloneLineup




func getTeamClone():
	var cloneTeam = {}
	for b in botCards:
		var botCard = botCards[b].cloneSelf()
		cloneTeam[b] = botCard
	return cloneTeam



