extends "res://game/towers/base_projectile.gd"

var already_hit_enemy: bool

func _ready() -> void:
	already_hit_enemy = false
	add_to_group("cannonball")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		if self.already_hit_enemy:
			return

		body.take_damage(self.damage)
		self.already_hit_enemy = true
		queue_free()
