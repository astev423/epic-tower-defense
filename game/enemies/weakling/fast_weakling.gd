extends "res://game/enemies/base_enemy.gd"

func _ready() -> void:
	movement_speed = 500


## Add money to the money manager then die
func handle_death() -> void:
	get_tree().call_group("resource_manager", "add_money", 50)
	queue_free()
