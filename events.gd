extends Node


signal game_start
signal game_over

signal game_editLineupMode
signal game_battleMode
signal game_mainMenuMode

signal game_updateScoreBackend(newScore)
signal game_updateScoreFrontend(newScore)

signal battle_render
signal battle_start
signal battle_nextFrame

signal battle_ended(winningTeam)


signal ui_toggleMainMenu
signal ui_showMainMenu
signal ui_hideMainMenu
signal ui_bgZoomIn
signal ui_bgZoomOut


signal ui_muteMusic
signal ui_unmuteMusic
signal ui_toggleMusicMute



signal debug_message(msg)

signal teamWiped(losingTeam)



