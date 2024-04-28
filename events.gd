extends Node

signal game_start
signal game_over

signal mode_mainMenu
signal mode_settingsMenu
signal mode_editLineup
signal mode_battle
signal mode_gameOver

signal game_updateSessionScore(intModifier) # 1 to add 1, -1 to take 1
signal game_setSessionScore(newScore) # will equal this score


signal ui_showMainMenu
signal ui_hideMainMenu
signal ui_bgZoomIn
signal ui_bgZoomOut


signal ui_toggleMusicMute



signal debug_message(msg)
signal debug_playerTeam




