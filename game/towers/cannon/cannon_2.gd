extends "res://game/towers/cannon/base_cannon.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectile_scene = preload("res://game/towers/cannon/cannonball_2.tscn")
	set_stats(1, 5, 200, 800, "800")
	super._ready()
