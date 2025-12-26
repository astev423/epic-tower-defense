extends "res://game/towers/base_tower.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cannonball_scene = preload("res://game/towers/cannon/cannonball_2.tscn")
	attack_range_area_hitbox.scale *= Vector2(1.2, 1.2)
	attack_range_display.scale *= Vector2(1.2, 1.2)
	set_stats(1, 5, 200)
	super._ready()
