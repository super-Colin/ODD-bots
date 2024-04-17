extends Node

var activeFrame
var escapeMenuActive = false

var mainMenuActive = true

@onready var bgStartingScale = $Background/Arena.scale
@onready var bgDoorStartingPosition = $Background/Door.scale
#var bgZoomedInScale = Vector2(1.5, 1.5)
@onready var bgZoomedInScale = bgStartingScale


# Called when the node enters the scene tree for the first time.
func _ready():
	%StartGameButton.pressed.connect(gameStart)
	%StartBattleButton.pressed.connect(func():Events.battle_start.emit())
	%RenderBattle.pressed.connect(func():Events.battle_render.emit())
	%NextFrame.pressed.connect(func():Events.battle_nextFrame.emit())
	Events.ui_hideMainMenu.connect(hideMainMenu)
	Events.ui_showMainMenu.connect(showMainMenu)
	Events.ui_bgZoomIn.connect(ui_bgZoomIn)
	Events.game_editLineupMode.connect(ui_bgZoomOut)
	Events.game_battleMode.connect(ui_bgZoomIn)
	Events.game_updateScoreFrontend.connect(updateScore)
	Events.game_over.connect(showGameOver)
	Events.game_start.connect(hideGameOver)
	%RestartGameButton.pressed.connect(confirmGameOver)

	%ToggleMusicMute.pressed.connect(func(): Events.ui_toggleMusicMute.emit())
	Events.ui_toggleMusicMute.connect(toggleMusicMute)

func toggleMusicMute():
	if not Globals.musicMuted:
		print("volume is ", $AudioStreamPlayer.volume_db)
		$AudioStreamPlayer.volume_db = -100
		Globals.musicMuted = true
	else:
		print("volume is ", $AudioStreamPlayer.volume_db)
		$AudioStreamPlayer.volume_db = -1.0
		Globals.musicMuted = false

func confirmGameOver():
	Events.game_start.emit()

func showGameOver():
	$GameOver.visible = true

func hideGameOver():
	$GameOver.visible = false

func updateScore():
	%SessionScore.text = "Total Waves Survived: %s" % Globals.sessionScore


func gameStart():
	hideGameOver()
	Events.game_start.emit()
	hideMainMenu()
	


func hideMainMenu():
	$MainMenu.visible = false


func showMainMenu():
	hideGameOver()
	$MainMenu.visible = true
	ui_bgZoomOut()

func ui_bgZoomIn():
	var tween = get_tree().create_tween()
	tween.tween_property($Background, "scale", bgZoomedInScale, 1)
	bg_openDoor()
	#var tween2 = get_tree().create_tween()
	#tween2.tween_property($Background/Door, "position", bgDoorStartingPosition + Vector2(100, -100), 1)

func bg_openDoor():
	var tween2 = get_tree().create_tween()
	tween2.tween_property($Background/Door, "position", bgDoorStartingPosition + Vector2(100, -100), 1)

func bg_closeDoor():
	var tween2 = get_tree().create_tween()
	tween2.tween_property($Background/Door, "position", bgDoorStartingPosition, 1)



func ui_bgZoomOut():
	var tween = get_tree().create_tween()
	tween.tween_property($Background/Arena, "scale", bgStartingScale, 1)
	bg_closeDoor()
	#var tween2 = get_tree().create_tween()
	#tween2.tween_property($Background/Door, "position", bgDoorStartingPosition, 1)




