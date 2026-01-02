extends ProgressBar

@onready var timer := $Timer
@onready var damage_bar := $DamageBar


func init_healthbar(health: float) -> void:
	# Progressbar depends on max value and value, if val at 50% max value then progressbar is half full
	# Need to set max values first or else the normal value gets clamped to 100 as max defaults to that
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health


func set_health(new_health: float) -> void:
	value = clampf(new_health, 0, max_value)
	timer.start()


func _on_timer_timeout() -> void:
	damage_bar.value = value
