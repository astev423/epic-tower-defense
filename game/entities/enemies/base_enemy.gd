extends CharacterBody2D
## Abstract base class for all monsters, it generates a path for the enemy to follow, connects the enemy
## to its health component, moves the enemy along the path, takes damage if projectile hits it, and
## frees itself once health drops to 0 or below
##
## To make a new enemy just extend this class, define its movement speed and health, and add the sprite
## and hitbox area

@onready var target_pos: Marker2D =  $"../../EnemyExitPoint"
@onready var pathfinding_manager: Node = $"../../EnemyPathfinder"
@onready var health_comp: Node2D = $HealthComponent
@onready var death_sound: AudioStreamPlayer = $DeathSound
@export var stats: EnemyStats
var path_array: Array[Vector2] = []
var died := false


func _ready() -> void:
	health_comp.health_bar_offset = stats.health_bar_offset

func setup_path_and_info() -> void:
	path_array = pathfinding_manager.get_valid_path(global_position / 64, target_pos.position / 64)
	health_comp.init_health(stats.health)
	health_comp.died.connect(_on_death)
	add_to_group("enemies")


func _physics_process(delta: float) -> void:
	move_to_closest_point_on_path(delta)
	move_and_slide()


## Array is reversed so we can remove the end instead of the front to prevent shifting
func move_to_closest_point_on_path(delta: float) -> void:
	if path_array.is_empty():
		EventBus.enemy_reached_end.emit(stats.lives_taken_if_reach_finish)
		queue_free()
		return

	var remaining := stats.movement_speed * delta

	while remaining > 0.0 and !path_array.is_empty():
		var target_point := path_array[-1]
		var vector_to_point := target_point - global_position
		var dist_to_point := vector_to_point.length()

		if dist_to_point < 0.001:
			path_array.resize(path_array.size() - 1)
			continue

		# If distance less than remaining we snap to the position to prevent going past it
		if dist_to_point <= remaining:
			global_position = target_point
			remaining -= dist_to_point
			path_array.resize(path_array.size() - 1)
		# Otherwise just head down that path
		else:
			var dir := vector_to_point / dist_to_point
			velocity = dir * stats.movement_speed
			return

	velocity = Vector2.ZERO


## We need bool check here because queue_free is not instant and this can be called twice
## Queue free is at END of current frame which is why it is called QUEUE
func _on_death() -> void:
	if died:
		return

	EventBus.enemy_died.emit()
	GameState.add_money(stats.money_awarded_if_killed)
	died = true
	death_sound.play()
	set_physics_process(false)
	await death_sound.finished
	queue_free()


func take_damage(amount: float, attack_type: GameTypes.AttackType) -> void:
	var damage_multiplier: float = stats.damage_modifiers.get(attack_type, 1.0)
	var wave_multiplier := 1.0
	if GameState.get_cur_wave_num() > 25:
		wave_multiplier = 0.75

	health_comp.take_damage(amount * damage_multiplier * wave_multiplier)
