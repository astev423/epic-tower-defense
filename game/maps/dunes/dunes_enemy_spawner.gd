extends "res://game/managers/enemies/spawning/base_enemy_spawner.gd"


func _ready() -> void:
	wave_info = PlainsWaveInfo.new()
	spawn_point = Vector2(32, 928)
	super._ready()
