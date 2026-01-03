extends "res://game/entities/towers/base_projectile.gd"


func _physics_process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if not body.is_in_group("enemies"):
			return

		body.take_damage(damage)


## Same as other projectiles but this doesn't queue free, it only frees once tower stops attacking
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.take_damage(self.damage)
