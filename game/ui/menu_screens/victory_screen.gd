extends Control

@onready var rng := RandomNumberGenerator.new()
@export var main_menu_screen_scene: PackedScene
@export var fireworks_scene: PackedScene


func _ready() -> void:
	spawn_fireworks()


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


func _on_quit_button_pressed() -> void:
	var main_menu_node: Control = main_menu_screen_scene.instantiate()
	main_menu_node.size = Vector2(1920, 1080)
	get_node("/root/GameRoot").add_child(main_menu_node)

	queue_free()


func _on_play_button_pressed() -> void:
	var main_menu_node: Control = main_menu_screen_scene.instantiate()
	main_menu_node.size = Vector2(1920, 1080)
	get_node("/root/GameRoot").add_child(main_menu_node)
	get_node("/root/GameRoot/MenuBGM").play()

	queue_free()
