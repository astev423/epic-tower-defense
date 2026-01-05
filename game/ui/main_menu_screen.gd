extends Control

signal show_levels_ui()


func _on_play_button_pressed() -> void:
	show_levels_ui.emit()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
