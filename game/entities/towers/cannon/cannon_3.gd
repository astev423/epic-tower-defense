extends "res://game/entities/towers/cannon/base_cannon.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectile_scene = preload("res://game/entities/towers/cannon/cannonball_3.tscn")
	type = GameTypes.TowerType.CANNON3
	set_stats(1.0, 20, 800, 1000, "MAX")
	super._ready()
