extends "res://game/entities/towers/crossbow/base_crossbow.gd"


func _ready() -> void:
	projectile_scene = preload("res://game/entities/towers/crossbow/bolt_3.tscn")
	type = GameTypes.TowerType.CROSSBOW3
	set_stats(.5, 80, 4000, 4000, "MAX")
	super._ready()
