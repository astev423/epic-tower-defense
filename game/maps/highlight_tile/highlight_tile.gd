extends Node2D

const MAP_CONSTANTS = preload("res://game/maps/levels.gd")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		snap_highlight_to_tile()


func snap_highlight_to_tile() -> void:
	var grid_pos: Vector2i = get_global_mouse_position() / MAP_CONSTANTS.TILE_SIZE
	var snapped_pos: Vector2i = grid_pos * MAP_CONSTANTS.TILE_SIZE
	var map_boundary: Vector2i = Vector2i(MAP_CONSTANTS.TILE_SIZE * (MAP_CONSTANTS.NUM_HORIZONTAL_TILES - 1),
										  MAP_CONSTANTS.TILE_SIZE * (MAP_CONSTANTS.NUM_VERTICAL_TILES - 1))
	self.position.x = min(snapped_pos.x, map_boundary.x)
	self.position.y = min(snapped_pos.y, map_boundary.y)
