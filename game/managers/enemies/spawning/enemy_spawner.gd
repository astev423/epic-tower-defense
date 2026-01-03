extends Node2D

const cpu_particles_scene = preload("res://game/maps/victory_fireworks.tscn")

# Variables for all waves
@onready var spawn_marker: Marker2D = $SpawnPoint
@onready var exit_marker: Marker2D = $ExitPoint
var last_wave_num: int

# Variables holding info for just the current wave and group
@onready var spawn_timer: Timer = $TimeBetweenEnemies
var info_for_current_wave: Array
var cur_enemy_type: GameTypes.EnemyType
var cur_enemy_count: int
var enemies_in_cur_group_to_be_spawned: int
var time_between_enemies: float


func _ready() -> void:
	EventBus.enemy_died.connect(decrease_enemy_count)
	EventBus.enemy_reached_end.connect(_on_enemy_reached_end)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	last_wave_num = WaveInfo.waves.size()
	try_start_new_wave()


func _on_spawn_timer_timeout() -> void:
	try_spawning_enemy()


func _on_enemy_reached_end(lives_taken_if_reach_finish: int) -> void:
	GameState.decrease_lives(lives_taken_if_reach_finish)
	decrease_enemy_count()


func try_start_new_wave() -> void:
	if GameState.get_cur_wave_num() > last_wave_num:
		# TODO Spawn fireworks and show victory screen
		spawn_fireworks()
		return

	setup_wave()


func setup_wave() -> void:
	# Initially timer is short to allow quick spawning of first enemy
	spawn_timer.wait_time = 0.01
	spawn_timer.start()

	cur_enemy_count = 0
	info_for_current_wave = WaveInfo.waves[GameState.get_cur_wave_num()]
	# Reverse so we can pop back to prevent resizing
	info_for_current_wave.reverse()
	get_info_of_new_group()


func get_info_of_new_group() -> void:
	cur_enemy_type = info_for_current_wave.pop_back()
	enemies_in_cur_group_to_be_spawned = info_for_current_wave.pop_back()
	cur_enemy_count += enemies_in_cur_group_to_be_spawned
	time_between_enemies = info_for_current_wave.pop_back()
	spawn_timer.wait_time = time_between_enemies

	print_debug("enemies of ", cur_enemy_type, " spawning: ", enemies_in_cur_group_to_be_spawned)
	print_debug("total enemies in this wave so far: ", cur_enemy_count)


func try_spawning_enemy() -> void:
	if enemies_in_cur_group_to_be_spawned <= 0:
		if info_for_current_wave.size() == 0:
			spawn_timer.stop()
			print_debug("EVERYTHING IN WAVE SPAWNED")
			return
		else:
			get_info_of_new_group()
			print_debug("SPAWNING NEW GROUP FOR CURRENT WAVE")
			return

	var instantiated_enemy := get_enemy_type()
	spawn_and_setup_enemy(instantiated_enemy)


func get_enemy_type() -> CharacterBody2D:
	if cur_enemy_type == GameTypes.EnemyType.Weakling:
		return WaveInfo.ENEMY_WEAKLING_SCENE.instantiate()
	if cur_enemy_type == GameTypes.EnemyType.FastWeakling:
		return WaveInfo.ENEMY_FAST_WEAKLING_SCENE.instantiate()
	elif cur_enemy_type == GameTypes.EnemyType.Bubba:
		return WaveInfo.ENEMY_BUBBA_SCENE.instantiate()
	else:
		print("Trying to spawn enemy of unknown type, defaulting to fast weakling")
		return WaveInfo.ENEMY_FAST_WEAKLING_SCENE.instantiate()


func spawn_and_setup_enemy(spawned_enemy: CharacterBody2D) -> void:
	add_child(spawned_enemy)
	spawned_enemy.global_position = spawn_marker.global_position
	spawned_enemy.setup_path_and_info()
	spawned_enemy.z_index = 1
	enemies_in_cur_group_to_be_spawned -= 1


func decrease_enemy_count() -> void:
	cur_enemy_count -= 1
	print_debug("decreasing enemies to", cur_enemy_count)

	if cur_enemy_count <= 0:
		print_debug("WAVE OVER ALL ENEMIES DIED")
		GameState._on_wave_over(GameState.get_cur_wave_num())
		EventBus.pause_event.emit()
		spawn_timer.stop()
		try_start_new_wave()


func spawn_fireworks() -> void:
	var p := cpu_particles_scene.instantiate() as CPUParticles2D
	p.global_position = Vector2(1000, 500)
	get_tree().get_root().add_child.call_deferred(p)
	p.emitting = true
