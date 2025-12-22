extends Node2D

@export var cannon_scene: PackedScene = preload("res://game/towers/cannon/cannon.tscn")
@onready var select_cannon: Button = $SelectCannon
@onready var tile_map_layer: TileMapLayer = $"../Maps/Plains/TileMapLayer"
@onready var highlight_tile: Node2D = $"../Maps/Plains/HighlightTile"


enum HeldTower {
	CANNON,
	CROSSBOW,
	NONE,
}
var held_tower = HeldTower.NONE
var held_tower_instance: Node2D = null


func _ready() -> void:
	select_cannon.pressed.connect(on_select_cannon_pressed)


## Do nothing if no selected tower, otherwise place/unselect depending on input
func _process(delta: float) -> void:
	if not is_instance_valid(held_tower_instance):
		return

	make_tower_follow_mouse()
	if Input.is_action_just_pressed("left_mouse") and is_valid_place_location():
		place_tower_on_grid()
	elif Input.is_action_just_pressed("esc"):
		deselect_held_tower()


func is_valid_place_location() -> bool:
	return true


func place_tower_on_grid() -> void:
	# This converts the local pos of the mouse to the tile number using local_to_map
	var cell_position: Vector2i = tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
	# Get data associated with that cell, see if it has placeable marked as true in tileset
	var cell_data = tile_map_layer.get_cell_tile_data(cell_position).get_custom_data("placeable")
	print_debug(cell_data)


func make_tower_follow_mouse() -> void:
	held_tower_instance.global_position = get_global_mouse_position()


## Remove previous tower instantiation if it exists and make new instatiation of right type
func on_select_cannon_pressed() -> void:
	held_tower = HeldTower.CANNON

	if held_tower_instance != null:
		held_tower_instance.queue_free()

	held_tower_instance = cannon_scene.instantiate()
	get_parent().add_child(held_tower_instance)


func deselect_held_tower() -> void:
	held_tower = HeldTower.NONE

	if held_tower_instance != null:
		held_tower_instance.queue_free()
