extends "res://game/towers/base_projectile.gd"

var explosion_scene: PackedScene
var spawned_explosion: bool


func _ready() -> void:
	add_to_group("rocket")
	explosion_scene = preload("res://game/towers/rocket_launcher/explosion.tscn")
	spawned_explosion = false


func _on_body_entered(body: Node2D) -> void:
	# Sometimes multiple explosions spawned at once, use bool check to prevent
	if spawned_explosion:
		return

	if body.is_in_group("enemies"):
		var explosion_node: Area2D = explosion_scene.instantiate()
		explosion_node.global_position = global_position
		explosion_node.damage = self.damage
		get_tree().get_root().add_child.call_deferred(explosion_node)
		queue_free()
		spawned_explosion = true
