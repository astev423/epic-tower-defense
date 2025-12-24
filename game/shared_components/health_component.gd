extends Node
class_name HealthComponent

@export var max_health := 10
var current_health := max_health

signal health_changed(new_health)
signal died

func set_max_and_cur_health(amount) -> void:
	max_health = amount
	current_health = amount

func take_damage(amount) -> void:
	current_health = max(0, current_health - amount)
	health_changed.emit(current_health)

	if current_health <= 0:
		died.emit()


func heal(amount) -> void:
	current_health = min(max_health, current_health + amount)
	health_changed.emit(current_health)
