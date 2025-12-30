extends Node2D

enum Maps {
	PLAINS,
	DUNES
}

const TILE_SIZE = 64
const NUM_HORIZONTAL_TILES = 26
const NUM_VERTICAL_TILES = 15

@onready var tower_placement_manager: Node2D = $"../MapUI/TowerPlacementManager"
@onready var resource_manager: Node2D = $"../MapUI/ResourceManager"
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
	else:
		current_map = load("res://game/maps/dunes/dunes.tscn")
		path_to_tilemap = "Dunes/TileMapLayer"
		path_to_spawner = "Dunes/DunesEnemySpawner"


## Spawn map and tilemap and managers for that map
func instantiate_map_stuff() -> void:
	var map_node = current_map.instantiate()
	add_child(map_node)
	tower_placement_manager.tile_map_layer = get_node(path_to_tilemap)
	resource_manager.enemy_spawner = get_node(path_to_spawner)
	pause_unpause_alerter.enemy_spawner = get_node(path_to_spawner)
