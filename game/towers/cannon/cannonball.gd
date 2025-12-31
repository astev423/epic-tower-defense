extends "res://game/towers/base_projectile.gd"


func _ready() -> void:
	projectile_speed = 800
	add_to_group("cannonball")


## Logic for when bullet hits enemy, cannonball can't hit more than one enemy
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		if self.already_hit_enemy:
			return

		body.take_damage(self.damage)
		self.already_hit_enemy = true
		queue_free()
