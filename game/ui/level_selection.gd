extends Control

const MAPS_SCENE = preload("res://game/maps/maps.tscn")

var starting_wave_num: int
var is_unlimited_money_mode: bool
var maps_node: Node2D
var map_user_clicked: GameConstants.Maps


func _ready() -> void:
	starting_wave_num = 1
	is_unlimited_money_mode = false
	maps_node = MAPS_SCENE.instantiate()


func _on_select_dunes_button_pressed() -> void:
	map_user_clicked = GameConstants.Maps.DUNES
	setup_level_and_delete_this_ui()


func _on_select_plains_button_pressed() -> void:
	map_user_clicked = GameConstants.Maps.PLAINS
	setup_level_and_delete_this_ui()


func _on_select_dungeon_button_pressed() -> void:
	map_user_clicked = GameConstants.Maps.DUNGEON
	setup_level_and_delete_this_ui()



func setup_level_and_delete_this_ui() -> void:
	# Have to use get_node here because levels node is delayed spawning with @onready, no immediate acess
	var levels := maps_node.get_node("Levels")
	levels.map_user_clicked = map_user_clicked
	levels.starting_wave_num = starting_wave_num
	levels.is_unlimited_money_mode = is_unlimited_money_mode
	get_tree().root.add_child(maps_node)
	queue_free()
