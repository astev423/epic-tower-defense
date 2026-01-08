extends Control


func _on_go_back_button_pressed() -> void:
	EventBus.change_menu_screen_button_pressed.emit(GameTypes.MenuScreen.HOME)
