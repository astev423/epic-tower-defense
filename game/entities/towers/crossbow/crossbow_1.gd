extends "res://game/entities/towers/crossbow/base_crossbow.gd"


func _ready() -> void:
	projectile_scene = preload("res://game/entities/towers/crossbow/bolt_1.tscn")
	type = GameTypes.TowerType.CROSSBOW1
	set_stats(.5, 20, 800, 1800, "1600")
	super._ready()

func _process(delta) -> void:
	if is_shooting and animation not started:
		$AnimatedSprite2D.play("shooting")

	super._process(delta)

func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.play("default")
