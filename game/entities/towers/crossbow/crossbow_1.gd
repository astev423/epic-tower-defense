extends "res://game/entities/towers/crossbow/base_crossbow.gd"

var animation_started: bool

func _ready() -> void:
	projectile_scene = preload("res://game/entities/towers/crossbow/bolt_1.tscn")
	type = GameTypes.TowerType.CROSSBOW1
	set_stats(.5, 20, 800, 1800, "1600")
	super._ready()


func _physics_process(delta: float) -> void:
	if is_shooting and not animation_started:
		$AnimatedSprite2D.play("shooting")
		animation_started = true

	super._physics_process(delta)


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.play("default")
	animation_started = false
