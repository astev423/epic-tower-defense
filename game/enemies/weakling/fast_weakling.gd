extends "res://game/enemies/base_enemy.gd"

func _ready() -> void:
	movement_speed = 400
	health_comp.set_max_and_cur_health(10)
	lives_taken_if_reach_finish = 1
	money_awarded_if_killed = 50
