extends Node

const cpu_particles_scene = preload("res://game/maps/victory_fireworks.tscn")

var wave_info
var timer: Timer
var first_enemy_spawned
var spawn_point: Vector2
var enemy_type
var enemy_count
var enemies_in_group_to_be_spawned
var time_between_enemies

func _ready() -> void:
	EventBus.connect("enemy_died", decrease_enemy_count)
	add_to_group("plains_enemy_spawner")
	attempt_start_wave()


## This gets called once at start and then gets called each time wave is over
func attempt_start_wave() -> void:
	if GameState.get_cur_wave() > wave_info.waves.size():
		spawn_fireworks()
		return

	setup_wave()
	# Initially timer is short to allow quick spawning of first enemy
	create_timer_for_spawning_enemies(0.1)


## Initialize variables for wave
func setup_wave() -> void:
	enemy_count = 0
	setup_group_in_wave()


func setup_group_in_wave() -> void:
	first_enemy_spawned = false
	enemy_type = wave_info.waves[GameState.get_cur_wave()].pop_front()
	enemies_in_group_to_be_spawned = wave_info.waves[GameState.get_cur_wave()].pop_front()
	enemy_count += enemies_in_group_to_be_spawned
	time_between_enemies = wave_info.waves[GameState.get_cur_wave()].pop_front()
	print_debug("enemies of ", enemy_type, " spawning: ", enemies_in_group_to_be_spawned)
	print_debug("total enemies in this wave so far: ", enemy_count)


func attempt_spawning_enemy() -> void:
	# After first enemy spawned give timer the right interval between enemies
	if !first_enemy_spawned:
		create_timer_for_spawning_enemies(time_between_enemies)

	# Find out if there are more groups in wave or if we end it
	if enemies_in_group_to_be_spawned <= 0:
		if wave_info.waves[GameState.get_cur_wave()].size() == 0:
			timer.stop()
			print_debug("EVERYTHING IN WAVE SPAWNED")
			return
		else:
			setup_group_in_wave()
			return

	var spawned_enemy: CharacterBody2D
	if enemy_type == GameTypes.EnemyType.Weakling:
		spawned_enemy = wave_info.ENEMY_WEAKLING_SCENE.instantiate()
	if enemy_type == GameTypes.EnemyType.FastWeakling:
		spawned_enemy = wave_info.ENEMY_FAST_WEAKLING_SCENE.instantiate()
	elif enemy_type == GameTypes.EnemyType.Bubba:
		spawned_enemy = wave_info.ENEMY_BUBBA_SCENE.instantiate()

	spawn_and_setup_enemy(spawned_enemy)

	# Start next group instantly to prevent waves ending prematurely
	if enemies_in_group_to_be_spawned == 0:
		timer.stop()
		timer.wait_time = 0.1
		timer.start()


## Set position and methods for enemy, set connections, emit, and change spawner variables
func spawn_and_setup_enemy(spawned_enemy: CharacterBody2D) -> void:
	add_child(spawned_enemy)
	spawned_enemy.global_position = spawn_point
	spawned_enemy.setup_path_and_info()
	# Make enemies appear above everything else
	spawned_enemy.z_index = 1
	# Use unbind to ignore the parameter sent in died signal
	enemies_in_group_to_be_spawned -= 1
	first_enemy_spawned = true


## Set new timer, delete old one if it exists
func create_timer_for_spawning_enemies(interval: float) -> void:
	if timer != null:
		timer.queue_free()

	timer = Timer.new()
	add_child(timer)
	timer.wait_time = interval
	timer.connect("timeout", attempt_spawning_enemy)
	timer.start()


func decrease_enemy_count() -> void:
	enemy_count -= 1
	print_debug("decreasing enemies to", enemy_count)
	# If no enemies left then wave over so pause and call appropriate methods
	if enemy_count <= 0:
		print_debug("WAVE OVER ALL ENEMIES DIED")
		EventBus.pause_event.emit()
		GameState.handle_wave_over(GameState.get_cur_wave())
		timer.queue_free()
		attempt_start_wave()


func spawn_fireworks() -> void:
	var p := cpu_particles_scene.instantiate() as CPUParticles2D
	p.global_position = Vector2(1000, 500)
	get_tree().get_root().add_child.call_deferred(p)
	p.emitting = true
