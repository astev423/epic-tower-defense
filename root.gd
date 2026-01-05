extends Node2D

const LEVEL_SELECTION_SCENE = preload("res://game/ui/level_selection.tscn")

@onready var main_menu_screen: Control = $MainMenuScreen


func _ready() -> void:
	main_menu_screen.show_levels_ui.connect(show_levels_ui)


func show_levels_ui() -> void:
	main_menu_screen.queue_free()
	var map_node: Control = LEVEL_SELECTION_SCENE.instantiate()
	map_node.size = Vector2(1920, 1080)
	add_child(map_node)
