extends "res://game/entities/towers/crystal/base_crystal.gd"


func _ready() -> void:
	projectile_scene = preload("res://game/entities/towers/cannon/cannonball_1.tscn")
	type = GameTypes.TowerType.CRYSTAL2
	set_stats(60, 3, 2000, 10000, "100000")
	super._ready()
