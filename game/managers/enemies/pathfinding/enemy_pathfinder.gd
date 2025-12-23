extends Node2D

@onready var tile_map_grid: TileMapLayer = $"../TileMapLayer"
var astar_grid := AStarGrid2D.new()
var path_array: Array[Vector2i] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_up_astar_grid()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_up_astar_grid() -> void:
	# set region to tile map
	astar_grid.region = tile_map_grid.get_used_rect()
	astar_grid.cell_size = tile_map_grid.tile_set.tile_size
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER

	astar_grid.update()
	update_terrain_movement()


func update_terrain_movement() -> void:
	path_array.clear()
	for tile in tile_map_grid.get_used_cells():
		var movement_cost = tile_map_grid.get_cell_tile_data(tile).get_custom_data_by_layer_id(1)
		if movement_cost < 10:
			astar_grid.set_point_weight_scale(tile, movement_cost)
		else:
			astar_grid.set_point_solid(tile)



func get_valid_path(start_pos: Vector2i, end_pos: Vector2i) -> Array[Vector2i]:
	path_array.clear()

	for point in astar_grid.get_point_path(start_pos, end_pos):
		var cur_point: Vector2i = point
		# go to center of the cell by adding 32
		cur_point += astar_grid.cell_size / 2 as Vector2i
		path_array.append(cur_point)

	return path_array
