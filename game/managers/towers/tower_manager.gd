extends Node2D

enum HeldTower {
	CANNON,
	CROSSBOW,
	NONE,
}

const MAP_CONSTANTS = preload("res://game/maps/plains/plains.gd")
const PLACED_CANNON_SCENE = preload("res://game/towers/cannon/cannon1.tscn")
const DRAGGED_CANNON_SCENE = preload("res://game/managers/towers/dragged_cannon1.tscn")
const IS_PLACEABLE := "placeable"
const TOWER_GROUP := "TOWER_GROUP"

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
	if is_instance_valid(held_tower_instance):
		make_tower_follow_mouse()

	if Input.is_action_just_pressed("left_mouse"):
		attempt_placing_tower_on_grid()
	elif Input.is_action_just_pressed("right_mouse"):
		attempt_delete_tower_on_grid()
	elif Input.is_action_just_pressed("esc"):
		attempt_deselect_held_tower()


func attempt_placing_tower_on_grid() -> void:
	# Can't place on the tower selection UI
	var mouse_pos = get_global_mouse_position()
	if (mouse_pos.x > MAP_CONSTANTS.TILE_SIZE * MAP_CONSTANTS.NUM_HORIZONTAL_TILES
			or mouse_pos.y > MAP_CONSTANTS.TILE_SIZE * MAP_CONSTANTS.NUM_VERTICAL_TILES):
		return

	# Get local pos so we can map it to the right tile check tile data to see if its placeable
	var cell_position := tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
	var is_placeable = tile_map_layer.get_cell_tile_data(cell_position).get_custom_data("placeable")

	if is_placeable and not used_tiles.has(cell_position):
		var new_tower = PLACED_CANNON_SCENE.instantiate()
		get_parent().add_child(new_tower)
		new_tower.global_position = cell_position * 64
		used_tiles[cell_position] = new_tower
		new_tower.add_to_group(TOWER_GROUP)


## Free tower if it exists and mark tiles it occupied as placeable again
func attempt_delete_tower_on_grid() -> void:
	var cell_position := tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
	if used_tiles.has(cell_position):
		var tower = used_tiles[cell_position]
		tower.queue_free()
		used_tiles.erase(cell_position)


func make_tower_follow_mouse() -> void:
	held_tower_instance.global_position = get_global_mouse_position()


## Remove previous tower instantiation if it exists and make new instatiation of right type
func on_select_cannon_pressed() -> void:
	held_tower = HeldTower.CANNON

	if held_tower_instance != null:
		held_tower_instance.queue_free()

	held_tower_instance = DRAGGED_CANNON_SCENE.instantiate()
	get_parent().add_child(held_tower_instance)


func attempt_deselect_held_tower() -> void:
	held_tower = HeldTower.NONE

	if held_tower_instance != null:
		held_tower_instance.queue_free()
		held_tower_instance = null
