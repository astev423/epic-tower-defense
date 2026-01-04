extends Node2D

@export var tower_placement_manager: Node2D
var current_map: PackedScene


func _ready() -> void:
	var map_user_clicked := GameConstants.Maps.PLAINS
	get_map_info_for_map_clicked(map_user_clicked)
	instantiate_map_stuff()


func get_map_info_for_map_clicked(map_user_clicked: GameConstants.Maps) -> void:
	if map_user_clicked == GameConstants.Maps.DUNES:
		current_map = load("res://game/maps/levels/dunes.tscn")
		GameState.set_variables(300, 300, 1)
	elif map_user_clicked == GameConstants.Maps.PLAINS:
		current_map = load("res://game/maps/levels/plains.tscn")
		GameState.set_variables(300, 300000, 18)
	elif map_user_clicked == GameConstants.Maps.DUNGEON:
		current_map = load("res://game/maps/levels/dungeon.tscn")
		GameState.set_variables(300, 300, 1)
	else:
		print("FATAL ERROR ON MAP SELECTION, CRASHING")
		get_tree().quit()


## Spawn map and tilemap and managers for that map
func instantiate_map_stuff() -> void:
	var map_node: Node2D = current_map.instantiate()
	add_child(map_node)

	var tile_layer := map_node.get_node("TileMapLayer")
	tower_placement_manager.tile_map_layer = tile_layer
