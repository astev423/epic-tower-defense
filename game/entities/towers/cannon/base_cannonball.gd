extends "res://game/entities/towers/base_projectile.gd"

var already_hit_enemy: bool


func _ready() -> void:
	already_hit_enemy = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		if self.already_hit_enemy:
			return

		body.take_damage(self.damage, attack_type)
		self.already_hit_enemy = true
		queue_free()
