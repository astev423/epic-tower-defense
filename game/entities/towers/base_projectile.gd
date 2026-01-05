extends Area2D

var projectile_speed: float
var direction: Vector2
var damage: float
var attack_type: GameTypes.AttackType


func _physics_process(delta: float) -> void:
	global_position += direction * projectile_speed * delta
	rotation = direction.angle()

	if global_position.x > 1664 or global_position.y > 1026:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.take_damage(self.damage, attack_type)
		queue_free()
