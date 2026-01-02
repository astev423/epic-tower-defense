extends "res://game/entities/towers/base_tower.gd"

## Idea of crossbow is to be powerful single target tower with big range, but slow and expensive

var animation_started: bool

func _physics_process(delta: float) -> void:
	if is_shooting and not animation_started:
		$AnimatedSprite2D.play("shooting")
		animation_started = true

	super._physics_process(delta)


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.play("default")
	animation_started = false
