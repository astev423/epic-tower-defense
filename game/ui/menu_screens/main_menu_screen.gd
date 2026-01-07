extends Control

var level_selection_menu_scene := load("res://game/ui/menu_screens/level_selection.tscn")


func _on_play_button_pressed() -> void:
	var level_selection_node: Control = level_selection_menu_scene.instantiate()
	level_selection_node.size = Vector2(1920, 1080)
	get_node("/root/GameRoot").add_child(level_selection_node)
	queue_free()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
