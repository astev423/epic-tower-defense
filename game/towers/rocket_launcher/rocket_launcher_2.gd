extends "res://game/towers/rocket_launcher/base_rocket_launcher.gd"


func _ready() -> void:
	projectile_scene = preload("res://game/towers/rocket_launcher/rocket_1.tscn")
	set_stats(0.6, 5, 500, 1200, "1000")
	super._ready()
