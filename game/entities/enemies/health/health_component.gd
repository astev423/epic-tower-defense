extends Node2D

@onready var health_bar: ProgressBar = $HealthBar
@onready var target := get_parent() as CharacterBody2D
var _health: float
var health_bar_offset: Vector2

signal died()


func _ready() -> void:
	top_level = true


func _process(delta: float) -> void:
	global_position = target.global_position + health_bar_offset


func init_health(health: float) -> void:
	_health = health
	health_bar.init_healthbar(_health)


func take_damage(damage: float) -> void:
	_health -= damage
	health_bar.set_health(_health)

	if _health <= 0:
		died.emit()
