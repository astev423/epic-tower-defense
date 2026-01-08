extends Control

@export var menu_root_scene: PackedScene


func _on_play_button_pressed() -> void:
	var menu_root_node: Control = menu_root_scene.instantiate()
	get_node("/root/GameRoot/MenuUI").add_child(menu_root_node)

	queue_free()



func _on_quit_button_pressed() -> void:
	get_tree().quit()
