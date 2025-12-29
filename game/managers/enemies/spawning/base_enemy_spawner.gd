extends Node

const cpu_particles_scene = preload("res://game/maps/victory_fireworks.tscn")

# bubba slightly stronger weakling, (scale him up, change vals), hussar is super fast weakling
# tank is new model that is super slow but high hp
#
var wave_info
var timer: Timer
var spawn_point: Vector2
var cur_wave
var enemy_type
var enemy_count
var enemies_to_be_spawned
var time_between_enemies

signal enemy_spawned(enemy)
signal wave_over()

func _ready() -> void:
	add_to_group("plains_enemy_spawner")

	cur_wave = 7
	attempt_start_wave()


## This gets called once at start and then gets called each time wave is over
func attempt_start_wave() -> void:
	if cur_wave > wave_info.waves.size():
		print_debug("all waves done")
		var p := cpu_particles_scene.instantiate() as CPUParticles2D
		p.global_position = Vector2(1000, 500)
		get_tree().get_root().add_child(p)
		p.emitting = true
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
	enemy_type = wave_info.waves[cur_wave][0]
	enemy_count = wave_info.waves[cur_wave][1]
	enemies_to_be_spawned = enemy_count
	time_between_enemies = wave_info.waves[cur_wave][2]
	print_debug("total enemies in this wave: ", enemy_count)


func attempt_spawning_enemy() -> void:
	if enemies_to_be_spawned <= 0:
		timer.stop()
		return

	var spawned_enemy: CharacterBody2D
	if enemy_type == EnemyTypes.Type.Weakling:
		spawned_enemy = wave_info.ENEMY_WEAKLING_SCENE.instantiate()
		add_child(spawned_enemy)
	elif enemy_type == EnemyTypes.Type.Bubba:
		pass

	# Spawn enemy at spawnpoint for plains level and give them right path
	spawned_enemy.global_position = spawn_point
	spawned_enemy.setup_path_and_info()
	enemy_spawned.emit(spawned_enemy)
	spawned_enemy.connect("enemy_reached_end", decrease_enemy_count)
	enemies_to_be_spawned -= 1


func decrease_enemy_count() -> void:
	enemy_count -= 1
	print_debug("decreasing enemies to", enemy_count)
	if enemy_count <= 0:
		print_debug("WAVE OVER ALL ENEMIES DIED")
		wave_over.emit()
		timer.queue_free()
		cur_wave += 1
		attempt_start_wave()
