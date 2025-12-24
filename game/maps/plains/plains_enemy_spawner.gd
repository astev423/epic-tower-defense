extends "res://game/managers/enemies/spawning/base_enemy_spawner.gd"

const ENEMY_WEAKLING_SCENE = preload("res://game/enemies/weakling/weakling.tscn")

@onready var all_waves := []
@onready var time_between_monsters: float = 1
@onready var wave_one_started = false
@onready var wave_one_enemies = [
	EnemyType.Weakling, EnemyType.Weakling, EnemyType.Weakling, EnemyType.Weakling, EnemyType.Weakling,
	EnemyType.Weakling, EnemyType.Weakling, EnemyType.Weakling, EnemyType.Weakling, EnemyType.Weakling,
]
var timer_between_monsters: Timer


func _ready() -> void:
	timer_between_monsters = Timer.new()
	add_child(timer_between_monsters)
	timer_between_monsters.one_shot = false
	timer_between_monsters.connect("timeout", attempt_spawning_next_enemy)
	timer_between_monsters.wait_time = time_between_monsters
	timer_between_monsters.start()
	#spawn_wave()


#func spawn_wave() -> void:
#	for enemy in wave_one_enemies:
#		attempt_spawning_next_enemy()
#
#	# Start time_between_monsters after first wave spawns for consistent time between waves
#	if not wave_one_started:
#		time_between_monsters.start()


func attempt_spawning_next_enemy() -> void:
	if wave_one_enemies.is_empty():
		timer_between_monsters.stop()
		return

	var next_enemy = wave_one_enemies.pop_front()
	next_enemy = ENEMY_WEAKLING_SCENE.instantiate()
	next_enemy.global_position += Vector2(160, 32)
	get_parent().add_child.call_deferred(next_enemy)
