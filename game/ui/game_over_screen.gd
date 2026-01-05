extends Control


func _on_play_button_pressed() -> void:
	var MAIN_MENU_SCREEN_SCENE := load("res://game/ui/main_menu_screen.tscn")
	var main_menu_node: Control = MAIN_MENU_SCREEN_SCENE.instantiate()
	main_menu_node.size = Vector2(1920, 1080)
	get_node("/root/GameRoot").add_child(main_menu_node)

	queue_free()



func _on_quit_button_pressed() -> void:
	get_tree().quit()
