extends Node




func _ready():
	%Button_StartGame.pressed.connect(func():Events.game_start.emit())
	Events.mode_mainMenu.connect(showMainMenu)
	Events.mode_battle.connect(hideMainMenu)
	Events.mode_gameOver.connect(showGameOver)
	Events.ui_hideMainMenu.connect(hideMainMenu)
	Events.game_start.connect(hideMainMenu)
	$Debug.visible = false
	connectDebugLayer()


func connectDebugLayer():
	$Debug.visible = true
	%Button_LogPlayerTeam.pressed.connect(func (): Events.debug_playerTeam.emit())
	%Button_LogPlayerTeam.pressed.connect(func (): print(Globals.playerTeam) )
	%Button_LogPlayerTeam.pressed.connect(func (): %DebugLabel.text = "%s" % Globals.playerTeam )
	$Debug/Button_LogPlayerBot1.pressed.connect(func (): %DebugLabel.text = "%s" % Globals.playerTeam.getBot(1) )


func showGameOver():
	$GameOver.visible = true



func showMainMenu():
	$MainMenu.visible = true
func hideMainMenu():
	$MainMenu.visible = false







