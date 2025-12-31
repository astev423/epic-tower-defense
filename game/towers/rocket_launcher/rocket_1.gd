extends "res://game/towers/rocket_launcher/base_rocket.gd"


func _ready() -> void:
	projectile_speed = 800
	add_to_group("rocket")
