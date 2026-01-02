extends "res://game/entities/towers/crystal/base_crystal.gd"


func _ready() -> void:
	projectile_scene = preload("res://game/entities/towers/cannon/cannonball_1.tscn")
	type = GameTypes.TowerType.CRYSTAL1
	set_stats(60, 1.5, 2000, 5000, "10000")
	super._ready()
