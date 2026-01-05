extends "res://game/entities/towers/base_projectile.gd"


func _physics_process(delta: float) -> void:
	for cur_enemy in get_overlapping_bodies():
		if not cur_enemy.is_in_group("enemies"):
			return
		if cur_enemy.died == true:
			continue

		cur_enemy.take_damage(damage, GameTypes.AttackType.Fire)


## Same as other projectiles but this doesn't queue free, it only frees once tower stops attacking
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.take_damage(self.damage, attack_type)
