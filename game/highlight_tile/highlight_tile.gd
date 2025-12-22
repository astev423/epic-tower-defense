extends Node2D

const TILE_SIZE = 64


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	snap_pos()

func snap_pos() -> void:
	var grid_pos: Vector2i = get_global_mouse_position() / TILE_SIZE
	var snapped_pos: Vector2i = grid_pos * TILE_SIZE
	var map_boundary: Vector2i = Vector2i(TILE_SIZE * 32, TILE_SIZE * 18)
	self.position.x = min(snapped_pos.x, map_boundary.x)
	self.position.y = min(snapped_pos.y, map_boundary.y)
