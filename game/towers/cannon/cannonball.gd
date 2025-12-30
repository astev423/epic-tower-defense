extends Area2D

var cannonball_speed: float = 800
var direction: Vector2
var damage: float
var already_hit_enemy: bool = false

func _ready() -> void:
	add_to_group("cannonball")


func _physics_process(delta: float) -> void:
	global_position = global_position + direction * cannonball_speed * delta
	if global_position.x > 1664 or global_position.y > 1026:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		queue_free()
