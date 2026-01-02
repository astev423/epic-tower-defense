extends "res://game/entities/towers/cannon/base_cannon.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectile_scene = preload("res://game/entities/towers/cannon/cannonball_2.tscn")
	type = GameTypes.TowerType.CANNON2
	set_stats(1, 5, 150, 900, "800")
	super._ready()
