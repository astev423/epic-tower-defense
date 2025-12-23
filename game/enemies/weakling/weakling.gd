extends CharacterBody2D

const MOVEMENT_SPEED := 40000

@export var pathfinding_manager: Node2D = null
@export var target_pos: Marker2D = null
var path_array: Array[Vector2i] = []


func _ready() -> void:
	path_array = pathfinding_manager.get_valid_path(global_position / 64, target_pos.position / 64)


func _process(delta) -> void:
	get_path_to_pos(delta)
	move_and_slide()


func get_path_to_pos(delta) -> void:
	if len(path_array) > 0:
		var dir: Vector2 = global_position.direction_to(path_array[0])
		self.velocity = dir * MOVEMENT_SPEED * delta
		if global_position.distance_to(path_array[0]) <= 10:
			path_array.remove_at(0)
	else:
		self.velocity = Vector2.ZERO
