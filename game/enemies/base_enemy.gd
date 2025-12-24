extends CharacterBody2D

@onready var target_pos: Marker2D =  $"../Marker2D"
@onready var pathfinding_manager: Node = $"../EnemyPathfinder"
@onready var health_comp: Node = $"HealthComponent"
@onready var movement_speed = 100
var path_array: Array[Vector2i] = []


## Get path array specific to that monster
func _ready() -> void:
	path_array = pathfinding_manager.get_valid_path(global_position / 64, target_pos.position / 64)
	health_comp.connect("died", handle_death)
	add_to_group("enemies")


func _process(delta) -> void:
	move_to_closest_point_on_path()
	move_and_slide()


## Path array contains the next point we need to move to, so continaully move towards each point
## and pop that point of if we are next to it so we can go to the next point
func move_to_closest_point_on_path() -> void:
	if len(path_array) > 0:
		var dir: Vector2 = global_position.direction_to(path_array[0])
		self.velocity = dir * movement_speed
		self.rotation = dir.angle()

		# If we are close to end of current point then remove it to get the next point, otherwise
		# don't remove just yet as its not near the right point
		if global_position.distance_to(path_array[0]) <= 2:
			path_array.remove_at(0)
	else:
		self.velocity = Vector2.ZERO


func _on_hitbox_area_area_entered(body: Area2D) -> void:
	if body.is_in_group("cannonball1"):
		print("light")
		health_comp.take_damage(2.5)
	elif body.is_in_group("cannonball2"):
		health_comp.take_damage(5)
		print("big damage")


func handle_death() -> void:
	queue_free()


func take_damage(amount) -> void:
	health_comp.take_damage(amount)
