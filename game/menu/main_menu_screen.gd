extends Control


func _on_play_button_pressed() -> void:
	EventBus.change_menu_screen_button_pressed.emit(GameTypes.MenuScreen.LEVEL_SELECTION)


func _on_tutorial_button_pressed() -> void:
	EventBus.change_menu_screen_button_pressed.emit(GameTypes.MenuScreen.TUTORIAL)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
