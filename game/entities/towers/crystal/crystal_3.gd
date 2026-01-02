extends "res://game/entities/towers/crystal/base_crystal.gd"


func _ready() -> void:
	projectile_scene = null
	type = GameTypes.TowerType.CRYSTAL3
	set_stats(60, 6, 50000, 100000, "MAX")
	super._ready()
