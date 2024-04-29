extends Node







########################
######## TEAM FUNCTIONS
########################

func team_addBot(team: Dictionary, bot:Dictionary):
	var pos = team.size() + 1
	if pos > Globals.conf_maxBotsPerTeam:
		print("team too large to add another")
		return team
	bot.position = pos
	team[pos] = bot_init(bot)
	return team



func team_getDamage(team):
	#print("getTeamDamage current team dict is : ", team)
	return bot_outgoingAttack(team[1])

func team_takeAttack(team: Dictionary, attack: Dictionary)->Dictionary:
	#print("getTeamDamage current team dict is : ", team)
	team[1] = bot_takeIncomingAttacks(team[1], attack)
	return team

func team_isDefeated(team):
	for lPos in team:
		if bot_isDead(team[lPos]):
			return true
	return false


########################
######## BOT FUNCTIONS
########################

func bot_init(botDict):
	if not botDict.has("totalHealth"):
		botDict.totalHealth = botDict.baseHealth
	if not botDict.has("totalAttack"):
		botDict.totalAttack = botDict.baseAttack
	botDict.remainingHealth = botDict.totalHealth
	return botDict


func bot_outgoingAttack(botDict):
	if bot_isDead(botDict):
		return {"damage":0, "fromPosition":1, "toPosition":1}
	return {"damage":botDict.totalAttack, "fromPosition":1, "toPosition":1}

func bot_takeIncomingAttacks(botDict, atkDict):
	#print("bot with health : , ", botDict.remainingHealth, " taking (atkDict) ", atkDict, " damage")
	botDict.remainingHealth -= atkDict.damage
	if botDict.remainingHealth <= 0:
		botDict.dead = true
	return botDict

func bot_isDead(botDict):
	if botDict.remainingHealth <= 0:
		botDict.dead = true
		return true
	return false




















