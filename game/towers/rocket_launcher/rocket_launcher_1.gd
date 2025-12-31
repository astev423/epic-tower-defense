extends "res://game/towers/rocket_launcher/base_rocket_launcher.gd"


func _ready() -> void:
	projectile_scene = preload("res://game/towers/rocket_launcher/rocket_1.tscn")
	set_stats(1, 10, 100, 75, "200")
	super._ready()
