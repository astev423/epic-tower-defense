extends Node
class_name HealthComponent

var max_health: int
var current_health: int
var is_dead = false

signal health_changed(new_health)
signal died()

func set_max_and_cur_health(amount) -> void:
	max_health = amount
	current_health = amount

func take_damage(amount) -> void:
	if is_dead:
		return

	current_health = max(0, current_health - amount)
	health_changed.emit(current_health)

	if current_health <= 0:
		died.emit()
		is_dead = true
		get_tree().call_group("plains_enemy_spawner", "decrease_enemy_count")


func heal(amount) -> void:
	current_health = min(max_health, current_health + amount)
	health_changed.emit(current_health)
