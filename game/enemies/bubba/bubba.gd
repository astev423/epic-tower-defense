extends "res://game/enemies/base_enemy.gd"

func _ready() -> void:
	movement_speed = 40
	health_comp.set_max_and_cur_health(300)
	can_rotate = false
	lives_taken_if_reach_finish = 10
	money_awarded_if_killed = 200
