extends Area2D

var cannonball_speed: float = 800
var direction: Vector2
var damage: float
var already_hit_enemy: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("cannonball")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = global_position + direction * delta * cannonball_speed
	if global_position.x > 1664 or global_position.y > 1026:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		queue_free()
