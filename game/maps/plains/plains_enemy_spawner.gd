extends "res://game/managers/enemies/spawning/base_enemy_spawner.gd"

@onready var wave_info: WaveInfo = WaveInfo.new()
var timer: Timer
var time_between_enemies: float
var enemies := []
var total_enemies: int

signal wave_over()

func _ready() -> void:
	add_to_group("plains_enemy_spawner")
	start_wave_one()


func start_wave_one() -> void:
	setup_wave()

	timer = Timer.new()
	add_child(timer)
	timer.one_shot = false
	timer.wait_time = time_between_enemies
	timer.connect("timeout", attempt_spawning_enemy)
	timer.start()


## Initialize variables
func setup_wave() -> void:
	time_between_enemies = wave_info.waves[0][0]
	enemies.push_back(wave_info.waves[0][1][0])
	# for spawning all enemies
	#enemies = wave_info.waves[0][1]
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
	spawned_enemy.global_position = Vector2(224, 64)
	spawned_enemy.setup_path_and_info()


func decrease_enemy_count() -> void:
	total_enemies -= 1
	if total_enemies <= 0:
		wave_over.emit()
