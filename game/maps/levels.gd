extends Node2D

enum Maps {
	PLAINS,
	DUNES,
	DUNGEON
}

const TILE_SIZE = 64
const NUM_HORIZONTAL_TILES = 26
const NUM_VERTICAL_TILES = 15

@onready var tower_placement_manager: Node2D = $"../MapUI/TowerPlacementManager"
@onready var pause_unpause_alerter: Node = $"../PauseUnpauseAlerter"
var current_map: PackedScene
var path_to_tilemap: String
var path_to_spawner: String


func _ready() -> void:
	var map_user_clicked := Maps.PLAINS
	get_map_info_for_map_clicked(map_user_clicked)
	instantiate_map_stuff()


func get_map_info_for_map_clicked(map_user_clicked: Maps) -> void:
	if map_user_clicked == Maps.PLAINS:
		current_map = load("res://game/maps/plains/plains.tscn")
		path_to_tilemap = "Plains/TileMapLayer"
		path_to_spawner = "Plains/PlainsEnemySpawner"
		GameState.set_variables(300, 30000, 14)
	elif map_user_clicked == Maps.DUNES:
		current_map = load("res://game/maps/dunes/dunes.tscn")
		path_to_tilemap = "Dunes/TileMapLayer"
		path_to_spawner = "Dunes/DunesEnemySpawner"
		GameState.set_variables(300, 300, 1)
	elif map_user_clicked == Maps.DUNGEON:
		print("FATAL ERROR ON MAP SELECTION, CRASHING")
		get_tree().quit()
	else:
		print("FATAL ERROR ON MAP SELECTION, CRASHING")
		get_tree().quit()


## Spawn map and tilemap and managers for that map
func instantiate_map_stuff() -> void:
	var map_node: Node2D = current_map.instantiate()
	add_child(map_node)
	tower_placement_manager.tile_map_layer = get_node(path_to_tilemap)
