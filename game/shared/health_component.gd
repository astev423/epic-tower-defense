extends Node
class_name HealthComponent

var max_health: float
var current_health: float
var is_dead := false

signal health_changed(new_health: float)
signal died()

func set_max_and_cur_health(amount: float) -> void:
	max_health = amount
	current_health = amount

func take_damage(amount: float) -> void:
	if is_dead:
		return

	current_health = max(0, current_health - amount)
	health_changed.emit(current_health)

	if current_health <= 0:
		died.emit()
		is_dead = true


func heal(amount: float) -> void:
	current_health = min(max_health, current_health + amount)
	health_changed.emit(current_health)
