extends Area2D

# Damage and direction set by tower so modifications to tower also work here
var projectile_speed: float
var direction: Vector2
var damage: float


func _physics_process(delta: float) -> void:
	global_position = global_position + direction * projectile_speed * delta
	rotation = direction.angle()

	if global_position.x > 1664 or global_position.y > 1026:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.take_damage(self.damage)
		queue_free()
