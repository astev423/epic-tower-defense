extends "res://game/towers/rocket_launcher/base_rocket_launcher.gd"


func _ready() -> void:
	projectile_scene = preload("res://game/towers/rocket_launcher/rocket_1.tscn")
	type = GameTypes.TowerType.ROCKET_LAUNCHER2
	set_stats(0.8, 10, 500, 1600, "MAX")
	super._ready()
