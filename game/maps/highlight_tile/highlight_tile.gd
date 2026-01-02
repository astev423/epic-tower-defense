extends Node2D


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		snap_highlight_to_tile()


func snap_highlight_to_tile() -> void:
	var grid_pos: Vector2i = get_global_mouse_position() / GameConstants.TILE_SIZE
	var snapped_pos: Vector2i = grid_pos * GameConstants.TILE_SIZE
	var map_boundary: Vector2i = Vector2i(GameConstants.TILE_SIZE * (GameConstants.NUM_HORIZONTAL_TILES - 1),
										  GameConstants.TILE_SIZE * (GameConstants.NUM_VERTICAL_TILES - 1))
	self.position.x = min(snapped_pos.x, map_boundary.x)
	self.position.y = min(snapped_pos.y, map_boundary.y)
