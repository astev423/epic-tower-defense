extends Node

# bubba slightly stronger weakling, (scale him up, change vals), hussar is super fast weakling
# tank is new model that is super slow but high hp
#
var wave_info
var timer: Timer
var time_between_enemies: float
var enemies := []
var total_enemies: int
var spawn_point: Vector2

signal enemy_spawned(enemy)
signal wave_over()

func _ready() -> void:
	add_to_group("plains_enemy_spawner")

	var start_at_wave = 5
	for i in range(start_at_wave - 1):
		wave_info.waves.pop_front()

	attempt_start_wave()


## This gets called once at start and then gets called each time wave is over
func attempt_start_wave() -> void:
	if wave_info.waves.is_empty():
		print_debug("all waves done")
		return

	setup_wave()

	# Timer that runs with given interval and spawns a single enemy
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = false
	timer.wait_time = time_between_enemies
	timer.connect("timeout", attempt_spawning_enemy)
	timer.start()


## Initialize variables for wave
func setup_wave() -> void:
	time_between_enemies = wave_info.waves[0][0]
	enemies = wave_info.waves[0][1]
	total_enemies = enemies.size()
	print_debug("total enemies in this wave: ", total_enemies)
	wave_info.waves.pop_front()


func attempt_spawning_enemy() -> void:
	if enemies.is_empty():
		timer.stop()
		return

	var cur_enemy = enemies.pop_front()
	var spawned_enemy: CharacterBody2D
	if cur_enemy == EnemyTypes.Type.Weakling:
		spawned_enemy = wave_info.ENEMY_WEAKLING_SCENE.instantiate()
		add_child(spawned_enemy)
	elif cur_enemy == EnemyTypes.Type.Bubba:
		pass

	# Spawn enemy at spawnpoint for plains level and give them right path
	spawned_enemy.global_position = spawn_point
	spawned_enemy.setup_path_and_info()
	enemy_spawned.emit(spawned_enemy)
	spawned_enemy.connect("enemy_reached_end", decrease_enemy_count)


func decrease_enemy_count() -> void:
	total_enemies -= 1
	print_debug("decreasing enemies to", total_enemies)
	if total_enemies <= 0:
		print_debug("WAVE OVER ALL ENEMIES DIED")
		wave_over.emit()
		timer.queue_free()
		attempt_start_wave()
