extends "res://game/towers/cannon/base_cannon.gd"


func _ready() -> void:
	projectile_scene = preload("res://game/towers/cannon/cannonball_1.tscn")
	type = GameTypes.TowerType.CANNON1
	set_stats(1, 2.5, 100, 800, "200")
	super._ready()
