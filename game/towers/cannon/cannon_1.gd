extends "res://game/towers/cannon/base_cannon.gd"


func _ready() -> void:
	attack_range = 20
	tower_damage = 2.5
	attacks_per_second = 1
	cannonball_scene = preload("res://game/towers/cannon/cannonball1.tscn")
	super._ready()
