extends "res://game/towers/base_tower.gd"


func _ready() -> void:
	cannonball_scene = preload("res://game/towers/cannon/cannonball_1.tscn")
	set_stats(1, 2.5, 100)
	super._ready()
