extends Control

@onready var rng := RandomNumberGenerator.new()
@export var menu_root_scene: PackedScene
@export var fireworks_scene: PackedScene


func _ready() -> void:
	spawn_fireworks()


func _on_play_button_pressed() -> void:
	var menu_root_node: Control = menu_root_scene.instantiate()
	get_node("/root/GameRoot").add_child(menu_root_node)
	get_node("/root/GameRoot/MenuBGM").play()

	queue_free()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func spawn_fireworks() -> void:
	const TIMES_TO_SPAWN_FIREWORKS := 6

	# Visible screen area in pixels (0..size)
	var rect := get_viewport().get_visible_rect()
	var padding := 64.0

	for i in TIMES_TO_SPAWN_FIREWORKS:
		var p := fireworks_scene.instantiate() as CPUParticles2D

		var x := rng.randf_range(rect.position.x + padding, rect.position.x + rect.size.x - padding)
		var y := rng.randf_range(rect.position.y + padding, rect.position.y + rect.size.y - padding)
		p.global_position = Vector2(x, y)

		get_tree().current_scene.add_child.call_deferred(p)
		p.emitting = true

		await get_tree().create_timer(3.0).timeout
