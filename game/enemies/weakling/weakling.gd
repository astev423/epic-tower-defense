extends "res://game/enemies/base_enemy.gd"

func _ready() -> void:
	# We need to call parent ready as well to prevent this from overriding it
	super._ready()
