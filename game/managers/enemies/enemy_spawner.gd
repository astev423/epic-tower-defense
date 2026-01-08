extends Node2D


# Variables for all waves
@onready var spawn_marker: Marker2D = $SpawnPoint
@onready var exit_marker: Marker2D = $ExitPoint
@export var enemy_scenes: EnemyScenes
@export var victory_screen_scene: PackedScene
var last_wave_num: int
var reduced_damage_warning_shown := false

# Variables holding info for just the current wave and group
@onready var spawn_timer: Timer = $TimeBetweenEnemies
var info_for_current_wave: Array
var cur_enemy_type: GameTypes.EnemyType
var cur_enemy_count: int
var enemies_in_cur_group_to_be_spawned: int
var groups_left_in_cur_wave: int
var time_until_next_group_starts_spawning: int
var time_between_enemies: float
var first_enemy_in_group_spawned: bool
var wave_info: WaveInfo


func _ready() -> void:
	wave_info = WaveInfo.new()
	EventBus.enemy_died.connect(decrease_enemy_count)
	EventBus.enemy_reached_end.connect(_on_enemy_reached_end)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	last_wave_num = wave_info.waves.size()
	try_start_new_wave()


func _on_spawn_timer_timeout() -> void:
	try_spawning_enemy()


func _on_enemy_reached_end(lives_taken_if_reach_finish: int) -> void:
	GameState.decrease_lives(lives_taken_if_reach_finish)
	decrease_enemy_count()


func try_start_new_wave() -> void:
	var cur_wave := GameState.get_cur_wave_num()
	if cur_wave > last_wave_num:
		call_deferred("try_show_victory_screen")
		return
	elif cur_wave >= 26 and not reduced_damage_warning_shown:
		EventBus.wave_25_passed.emit()
		reduced_damage_warning_shown = true

	setup_wave()


func setup_wave() -> void:
	# Initially timer is short to allow quick spawning of first enemy
	spawn_timer.wait_time = 0.01
	spawn_timer.start()

	cur_enemy_count = 0
	info_for_current_wave = wave_info.waves[GameState.get_cur_wave_num()]
	# Reverse so we can pop back to prevent resizing
	info_for_current_wave.reverse()
	get_info_of_new_group()


func get_info_of_new_group() -> void:
	@warning_ignore("integer_division")
	groups_left_in_cur_wave = info_for_current_wave.size() / 3
	cur_enemy_type = info_for_current_wave.pop_back()
	enemies_in_cur_group_to_be_spawned = info_for_current_wave.pop_back()
	cur_enemy_count += enemies_in_cur_group_to_be_spawned
	time_between_enemies = info_for_current_wave.pop_back()
	if info_for_current_wave.size() > 0:
		time_until_next_group_starts_spawning = info_for_current_wave.pop_back()
	spawn_timer.wait_time = time_between_enemies
	first_enemy_in_group_spawned = false

	print_debug("enemies of type: ", cur_enemy_type, " spawning: ", enemies_in_cur_group_to_be_spawned)
	print_debug("total enemies in this wave so far: ", cur_enemy_count)


func try_spawning_enemy() -> void:
	if not first_enemy_in_group_spawned:
		setup_timer_to_spawn_each_enemy_in_group_at_right_time()

	if enemies_in_cur_group_to_be_spawned <= 0:
		if info_for_current_wave.size() == 0:
			spawn_timer.stop()
			print_debug("EVERYTHING IN WAVE SPAWNED")
			groups_left_in_cur_wave = 0
			if cur_enemy_count == 0:
				handle_wave_over()
			return
		else:
			get_info_of_new_group()
			groups_left_in_cur_wave -= 1
			setup_timer_to_pause_between_groups()
			return

	var instantiated_enemy := get_enemy_type()
	spawn_and_setup_enemy(instantiated_enemy)


func setup_timer_to_spawn_each_enemy_in_group_at_right_time() -> void:
	spawn_timer.stop()
	spawn_timer.wait_time = time_between_enemies
	first_enemy_in_group_spawned = true
	spawn_timer.start()


func setup_timer_to_pause_between_groups() -> void:
	spawn_timer.stop()
	spawn_timer.wait_time = time_until_next_group_starts_spawning
	spawn_timer.start()


func spawn_and_setup_enemy(spawned_enemy: CharacterBody2D) -> void:
	add_child(spawned_enemy)
	spawned_enemy.global_position = spawn_marker.global_position
	spawned_enemy.setup_path_and_info()
	spawned_enemy.z_index = 1
	enemies_in_cur_group_to_be_spawned -= 1


func decrease_enemy_count() -> void:
	cur_enemy_count -= 1
	print_debug("decreasing enemies to", cur_enemy_count, "groups left: ", groups_left_in_cur_wave)

	if cur_enemy_count <= 0 and groups_left_in_cur_wave <= 0:
		handle_wave_over()


func handle_wave_over() -> void:
	print_debug("WAVE OVER ALL ENEMIES DIED")
	GameState._on_wave_over(GameState.get_cur_wave_num())
	EventBus.pause_game.emit()
	spawn_timer.stop()
	try_start_new_wave()


func try_show_victory_screen() -> void:
	if GameState.get_cur_lives_num() <= 0:
		return

	Engine.time_scale = 1.0
	EventBus.game_timescale_changed.emit("1X")
	GameState.set_dying_animation(true)
	# Wait for monster death animation and sfx to finish
	await get_tree().create_timer(11.0).timeout
	GameState.set_dying_animation(false)
	var victory_screen_node: Control = victory_screen_scene.instantiate()
	victory_screen_node.size = Vector2(1920, 1080)
	get_node("/root/GameRoot").add_child(victory_screen_node)

	get_node("/root/GameRoot/GameplayScene").queue_free()


func get_enemy_type() -> CharacterBody2D:
	if cur_enemy_type == GameTypes.EnemyType.Weakling:
		return enemy_scenes.weakling.instantiate()
	elif cur_enemy_type == GameTypes.EnemyType.FastWeakling:
		return enemy_scenes.fast_weakling.instantiate()
	elif cur_enemy_type == GameTypes.EnemyType.Bubba:
		return enemy_scenes.bubba.instantiate()
	elif cur_enemy_type == GameTypes.EnemyType.UltraTank:
		return enemy_scenes.ultra_tank.instantiate()
	elif cur_enemy_type == GameTypes.EnemyType.Skeletor:
		return enemy_scenes.skeletor.instantiate()
	elif cur_enemy_type == GameTypes.EnemyType.Goblin:
		return enemy_scenes.goblin.instantiate()
	elif cur_enemy_type == GameTypes.EnemyType.ArmoredGrunt:
		return enemy_scenes.armored_grunt.instantiate()
	elif cur_enemy_type == GameTypes.EnemyType.Watery:
		return enemy_scenes.watery.instantiate()
	elif cur_enemy_type == GameTypes.EnemyType.Glug:
		return enemy_scenes.glug.instantiate()
	elif cur_enemy_type == GameTypes.EnemyType.BossMan:
		return enemy_scenes.bossman.instantiate()
	else:
		print_debug("Trying to spawn enemy of unknown type, defaulting to bossman")
		return enemy_scenes.bossman.instantiate()
