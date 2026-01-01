extends Node
class_name EnemyPathfinder

@onready var tile_map_grid: TileMapLayer = $"../TileMapLayer"
var astar_grid := AStarGrid2D.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_up_astar_grid()


## To set up astar we need the size, which get_used_rect returns, cell_size, and set if char can move
## diagnolly, then update grid and add tiles we can move on and which ones we can't
func set_up_astar_grid() -> void:
	astar_grid.region = tile_map_grid.get_used_rect()
	astar_grid.cell_size = tile_map_grid.tile_set.tile_size
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER

	astar_grid.update()
	# Without this char assumes all tiles are equal weight
	update_terrain_movement()


## Add tiles we can move on to astargrid and add tiles we can't
func update_terrain_movement() -> void:
	for tile in tile_map_grid.get_used_cells():
		var movement_cost: int = tile_map_grid.get_cell_tile_data(tile).get_custom_data_by_layer_id(1)
		if movement_cost < 10:
			astar_grid.set_point_weight_scale(tile, movement_cost)
		else:
			astar_grid.set_point_solid(tile)



## This returns an array of all the points along the path the enemy will move to get to end_pos
func get_valid_path(start_pos: Vector2, end_pos: Vector2) -> Array[Vector2]:
	var path_array: Array[Vector2]

	for point in astar_grid.get_point_path(start_pos, end_pos):
		var cur_point: Vector2 = point
		# go to center of the cell by adding 32
		cur_point += astar_grid.cell_size / 2
		path_array.append(cur_point)

	# Reverse so we can easily pop from end for O(1) time
	path_array.reverse()
	return path_array
