extends Node2D

enum HeldTower {
	CANNON,
	CROSSBOW,
	NONE,
}

const CANNON_SCENE := preload("res://game/towers/cannon/cannon.tscn")
const IS_PLACEABLE := "placeable"

@onready var select_cannon: Button = $SelectCannon
@onready var tile_map_layer: TileMapLayer = $"../Maps/Plains/TileMapLayer"
@onready var highlight_tile: Node2D = $"../Maps/Plains/HighlightTile"
var held_tower := HeldTower.NONE
var held_tower_instance: Node2D = null
var used_tiles: Dictionary = {}


func _ready() -> void:
	select_cannon.pressed.connect(on_select_cannon_pressed)


## Do nothing if no selected tower, otherwise place/unselect depending on input
func _process(delta: float) -> void:
	if not is_instance_valid(held_tower_instance):
		return

	make_tower_follow_mouse()
	if Input.is_action_just_pressed("left_mouse"):
		attempt_placing_tower_on_grid()
	elif Input.is_action_just_pressed("right_mouse"):
		attempt_delete_tower_on_grid()
	elif Input.is_action_just_pressed("esc"):
		deselect_held_tower()


func attempt_placing_tower_on_grid() -> void:
	# This converts the local pos of the mouse to the tile number using local_to_map
	var cell_position := tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
	# Get data associated with that cell, see if it has placeable marked as true in tileset
	var is_placeable = tile_map_layer.get_cell_tile_data(cell_position).get_custom_data("placeable")
	if is_placeable and !used_tiles.has(cell_position):
		var new_tower = CANNON_SCENE.instantiate()
		add_child(new_tower)
		new_tower.global_position = cell_position * 64
		mark_used_tiles(cell_position, new_tower)


func attempt_delete_tower_on_grid() -> void:
	var cell_position := tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
	var is_placeable = tile_map_layer.get_cell_tile_data(cell_position).get_custom_data("placeable")
	if is_placeable and used_tiles.has(cell_position):
		var tower = used_tiles[cell_position]
		erase_all_keys_with_value(tower)
		tower.queue_free()


## Can't use any tiles near tower
func mark_used_tiles(cell_position: Vector2i, new_tower) -> void:
	var x = cell_position.x
	var y = cell_position.y
	used_tiles[cell_position] = new_tower
	used_tiles[Vector2i(x + 1, y)] = new_tower
	used_tiles[Vector2i(x + 1, y + 1)] = new_tower
	used_tiles[Vector2i(x - 1, y)] = new_tower
	used_tiles[Vector2i(x - 1, y + 1)] = new_tower
	used_tiles[Vector2i(x, y + 1)] = new_tower
	used_tiles[Vector2i(x, y - 1)] = new_tower


func erase_all_keys_with_value(value_to_match) -> void:
	var keys_to_erase: Array = []
	for k in used_tiles.keys():
		if used_tiles[k] == value_to_match:
			keys_to_erase.append(k)
	for k in keys_to_erase:
		used_tiles.erase(k)


func make_tower_follow_mouse() -> void:
	held_tower_instance.global_position = get_global_mouse_position()


## Remove previous tower instantiation if it exists and make new instatiation of right type
func on_select_cannon_pressed() -> void:
	held_tower = HeldTower.CANNON

	if held_tower_instance != null:
		held_tower_instance.queue_free()

	held_tower_instance = CANNON_SCENE.instantiate()
	self.add_child(held_tower_instance)


func deselect_held_tower() -> void:
	held_tower = HeldTower.NONE

	if held_tower_instance != null:
		held_tower_instance.queue_free()
