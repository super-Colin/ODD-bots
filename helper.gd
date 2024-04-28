extends Node




func bot_init(botDict):
	if not botDict.has("totalHealth"):
		botDict.totalHealth = botDict.baseHealth
	if not botDict.has("totalAttack"):
		botDict.totalAttack = botDict.baseAttack
	botDict.remainingHealth = botDict.totalHealth


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




















