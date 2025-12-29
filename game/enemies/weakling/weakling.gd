extends "res://game/enemies/base_enemy.gd"

func _ready() -> void:
	movement_speed = 100
	health_comp.set_max_and_cur_health(10)
	lives_taken_if_reach_finish = 1


## Add money to the money manager then die
func handle_death() -> void:
	get_tree().call_group("resource_manager", "add_money", 10)
	queue_free()
