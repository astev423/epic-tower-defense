extends "res://game/entities/towers/base_tower.gd"

@onready var fire_node: Area2D = $Fire


func _ready() -> void:
	fire_node.damage = stats.tower_damage
	super._ready()


func _physics_process(delta: float) -> void:
	var is_enemy_in_range := false

	for cur_enemy in attack_range_area.get_overlapping_bodies():
		if not cur_enemy.is_in_group("enemies"):
			continue
		if cur_enemy.died == true:
			continue

		look_at(cur_enemy.global_position)
		rotation += deg_to_rad(90)

		if not is_shooting:
			start_shooting()

		is_enemy_in_range = true
		is_shooting = true
		break

	if not is_enemy_in_range:
		stop_shooting()


func stop_shooting() -> void:
	fire_node.process_mode = Node.PROCESS_MODE_DISABLED
	fire_node.visible = false
	projectile_sound.stop()
	is_shooting = false


func start_shooting() -> void:
	fire_node.process_mode = Node.PROCESS_MODE_INHERIT
	fire_node.visible = true
	projectile_sound.play()
	is_shooting = true
