extends "res://game/entities/towers/crossbow/base_crossbow.gd"


func _ready() -> void:
	projectile_scene = preload("res://game/entities/towers/crossbow/bolt_2.tscn")
	type = GameTypes.TowerType.CROSSBOW2
	set_stats(.5, 40, 1600, 2400, "4000")
	super._ready()
