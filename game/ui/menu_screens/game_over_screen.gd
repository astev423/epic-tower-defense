extends Control

@export var main_menu_screen_scene: PackedScene


func _on_play_button_pressed() -> void:
	var main_menu_node: Control = main_menu_screen_scene.instantiate()
	main_menu_node.size = Vector2(1920, 1080)
	get_node("/root/GameRoot").add_child(main_menu_node)

	queue_free()



func _on_quit_button_pressed() -> void:
	get_tree().quit()
