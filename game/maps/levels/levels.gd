extends Node2D

@export var tower_placement_manager: Node2D
var current_map: PackedScene
var starting_wave_num: int
var is_unlimited_money_mode: bool
var map_user_clicked: GameConstants.Maps


func _ready() -> void:
	print(starting_wave_num)
	set_variables_for_map_clicked()
	instantiate_map_stuff()


func set_variables_for_map_clicked() -> void:
	var starting_money := get_starting_money()
	if map_user_clicked == GameConstants.Maps.DUNES:
		current_map = load("res://game/maps/levels/dunes.tscn")
	elif map_user_clicked == GameConstants.Maps.PLAINS:
		current_map = load("res://game/maps/levels/plains.tscn")
	elif map_user_clicked == GameConstants.Maps.DUNGEON:
		current_map = load("res://game/maps/levels/dungeon.tscn")
	else:
		print("FATAL ERROR ON MAP SELECTION, CRASHING")
		get_tree().quit()

	GameState.set_variables(300, starting_money, starting_wave_num)


## Spawn map and tilemap and managers for that map
func instantiate_map_stuff() -> void:
	var map_node: Node2D = current_map.instantiate()
	add_child(map_node)

	var tile_layer := map_node.get_node("TileMapLayer")
	tower_placement_manager.tile_map_layer = tile_layer


func get_starting_money() -> int:
	if is_unlimited_money_mode:
		return 9999999
	elif starting_wave_num > 1:
		return WaveInfo.starting_money_at_given_wave[starting_wave_num]
	else:
		return 300
