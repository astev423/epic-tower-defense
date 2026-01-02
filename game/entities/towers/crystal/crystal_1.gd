extends "res://game/entities/towers/crystal/base_crystal.gd"


func _ready() -> void:
	projectile_scene = null
	type = GameTypes.TowerType.CRYSTAL1
	set_stats(60, 1.5, 2000, 100000, "10000")
	super._ready()
