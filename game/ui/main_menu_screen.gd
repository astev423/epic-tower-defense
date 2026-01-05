extends Control

const LEVEL_SELECTION_SCENE = preload("res://game/ui/level_selection.tscn")


func _on_play_button_pressed() -> void:
	var level_selection_node: Control = LEVEL_SELECTION_SCENE.instantiate()
	level_selection_node.size = Vector2(1920, 1080)
	get_node("/root/Root").add_child(level_selection_node)
	queue_free()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
