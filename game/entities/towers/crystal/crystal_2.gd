extends "res://game/entities/towers/crystal/base_crystal.gd"


func _ready() -> void:
	projectile_scene = null
	type = GameTypes.TowerType.CRYSTAL2
	set_stats(60, 3, 10000, 100000, "50000")
	super._ready()
