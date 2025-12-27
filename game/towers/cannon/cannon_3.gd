extends "res://game/towers/base_tower.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tower_scene = preload("res://game/towers/cannon/cannonball_3.tscn")
	attack_range_area_hitbox.scale *= Vector2(1.4, 1.4)
	attack_range_display.scale *= Vector2(1.4, 1.4)
	set_stats(1, 10, 800, 108, "MAX")
	super._ready()
