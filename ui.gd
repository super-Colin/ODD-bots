extends Node




func _ready():
	%Button_StartGame.pressed.connect(func():Events.game_start.emit())
	#%Button_ResetGame.pressed.connect(func (): Events.game_start.emit())
	$GameOver/Button_ResetGame.pressed.connect(func (): Events.mode_mainMenu.emit())
	$WinScreen/Button_ResetGame.pressed.connect(func (): Events.mode_mainMenu.emit())
	Events.mode_mainMenu.connect(showMainMenu)
	Events.mode_battle.connect(hideMainMenu)
	Events.mode_gameOver.connect(showGameOver)
	Events.mode_gameWin.connect(showWinScreen)
	Events.ui_hideMainMenu.connect(hideMainMenu)
	Events.game_start.connect(hideMainMenu)
	Events.game_updateSessionScore.connect(updateScore)
	Events.game_setSessionScore.connect(updateScore)
	$Debug.visible = false
	connectDebugLayer()


func connectDebugLayer():
	$Debug.visible = true
	%Button_LogPlayerTeam.pressed.connect(func (): Events.debug_playerTeam.emit())
	%Button_LogPlayerTeam.pressed.connect(func (): print(Globals.playerTeam) )
	%Button_LogPlayerTeam.pressed.connect(func (): %DebugLabel.text = "%s" % Globals.playerTeam )
	$Debug/Button_LogPlayerBot1.pressed.connect(func (): %DebugLabel.text = "%s" % Globals.playerTeam[1] )


func showGameOver():
	$GameOver.visible = true
	$MainMenu.visible = false
	$WinScreen.visible = false


func showWinScreen():
	$WinScreen.visible = true
	$MainMenu.visible = false
	$GameOver.visible = false

func showMainMenu():
	$MainMenu.visible = true
	$GameOver.visible = false
	$WinScreen.visible = false

func hideMainMenu():
	$MainMenu.visible = false


func updateScore():
	%Score.text = "Score: %s" % Globals.sessionScore





