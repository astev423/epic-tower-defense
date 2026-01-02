extends "res://game/entities/towers/rocket_launcher/base_rocket_launcher.gd"


func _ready() -> void:
	projectile_scene = preload("res://game/entities/towers/rocket_launcher/rocket_1.tscn")
	type = GameTypes.TowerType.ROCKET_LAUNCHER1
	set_stats(0.3, 5, 500, 1200, "1000")
	super._ready()
