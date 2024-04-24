extends Node




func _ready():
	%Button_StartGame.pressed.connect(func():Events.game_start.emit())
	Events.mode_mainMenu.connect(showMainMenu)
	Events.mode_battle.connect(hideMainMenu)
	Events.mode_gameOver.connect(showGameOver)
	Events.ui_hideMainMenu.connect(hideMainMenu)



func showGameOver():
	$GameOver.visible = true



func showMainMenu():
	$GameOver.visible = true
func hideMainMenu():
	$GameOver.visible = false







