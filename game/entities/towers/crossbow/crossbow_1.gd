extends "res://game/entities/towers/crossbow/base_crossbow.gd"


func _ready() -> void:
	projectile_scene = preload("res://game/entities/towers/crossbow/bolt_1.tscn")
	type = GameTypes.TowerType.CROSSBOW1
	set_stats(.5, 20, 800, 1800, "1600")
	super._ready()
