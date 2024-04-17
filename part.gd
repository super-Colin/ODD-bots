
class_name Part



var attackModifier
var healthModifier

#func setAttModifier

func _init(atk=1,hlth=1):
	attackModifier = atk
	healthModifier = hlth

func getBaseStats():
	return Vector2(attackModifier, healthModifier)

func partAttach():
	pass

func partDettach():
	pass
