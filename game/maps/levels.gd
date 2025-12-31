extends Node2D

enum Maps {
	PLAINS,
	DUNES
}

const TILE_SIZE = 64
const NUM_HORIZONTAL_TILES = 26
const NUM_VERTICAL_TILES = 15

@onready var tower_placement_manager: Node2D = $"../MapUI/TowerPlacementManager"
@onready var pause_unpause_alerter: Node = $"../PauseUnpauseAlerter"
var current_map: PackedScene
var map_user_clicked
var path_to_tilemap
var path_to_spawner


func _ready() -> void:
	map_user_clicked = Maps.DUNES
	get_map_info_for_map_clicked()
	instantiate_map_stuff()


## Get map scene and paths needed nodes
func get_map_info_for_map_clicked() -> void:
	if map_user_clicked == Maps.DUNES:
		current_map = load("res://game/maps/plains/plains.tscn")
		path_to_tilemap = "Plains/TileMapLayer"
		path_to_spawner = "Plains/PlainsEnemySpawner"
		GameState.cur_lives = 300
		GameState.cur_money = 3000
		GameState.cur_wave = 11
	else:
		current_map = load("res://game/maps/dunes/dunes.tscn")
		path_to_tilemap = "Dunes/TileMapLayer"
		path_to_spawner = "Dunes/DunesEnemySpawner"
		GameState.cur_lives = 300
		GameState.cur_money = 300
		GameState.cur_wave = 1


## Spawn map and tilemap and managers for that map
func instantiate_map_stuff() -> void:
	var map_node = current_map.instantiate()
	add_child(map_node)
	tower_placement_manager.tile_map_layer = get_node(path_to_tilemap)
