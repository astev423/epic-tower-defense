extends ProgressBar

@export var offset := Vector2(0, -40)
@onready var target := get_parent() as Node2D
@onready var timer := $Timer
@onready var damage_bar := $DamageBar
var _health: float

signal died()


func _ready() -> void:
	top_level = true


func _process(delta) -> void:
	global_position = target.global_position + offset


func init_health(health: float) -> void:
	_health = health
	max_value = health
	self.value = health
	damage_bar.max_value = health
	damage_bar.value = health


func _on_timer_timeout() -> void:
	damage_bar.value = _health


func take_damage(damage: float) -> void:
	print(_health)
	print(damage)
	set_health(_health - damage)


func set_health(new_health: float) -> void:
	var prev_health := _health
	_health = min(max_value, new_health)
	self.value = _health

	if _health <= 0:
		died.emit()
		queue_free()

	if _health < prev_health:
		timer.start()
	else:
		damage_bar.value = _health
