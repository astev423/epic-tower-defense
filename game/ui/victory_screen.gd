extends Control

const CPU_PARTICLES_SCENE := preload("res://game/maps/victory_fireworks.tscn")

@onready var rng := RandomNumberGenerator.new()


func _ready() -> void:
	spawn_fireworks()


func spawn_fireworks() -> void:
	const TIMES_TO_SPAWN_FIREWORKS := 6

	# Visible screen area in pixels (0..size)
	var rect := get_viewport().get_visible_rect()
	var padding := 64.0

	for i in TIMES_TO_SPAWN_FIREWORKS:
		var p := CPU_PARTICLES_SCENE.instantiate() as CPUParticles2D

		var x := rng.randf_range(rect.position.x + padding, rect.position.x + rect.size.x - padding)
		var y := rng.randf_range(rect.position.y + padding, rect.position.y + rect.size.y - padding)
		p.global_position = Vector2(x, y)

		get_tree().current_scene.add_child.call_deferred(p)
		p.emitting = true

		await get_tree().create_timer(3.0).timeout


func _on_quit_button_pressed() -> void:
	var MAIN_MENU_SCREEN_SCENE := load("res://game/ui/main_menu_screen.tscn")
	var main_menu_node: Control = MAIN_MENU_SCREEN_SCENE.instantiate()
	main_menu_node.size = Vector2(1920, 1080)
	get_node("/root/Root").add_child(main_menu_node)

	queue_free()


func _on_play_button_pressed() -> void:
	var MAIN_MENU_SCREEN_SCENE := load("res://game/ui/main_menu_screen.tscn")
	var main_menu_node: Control = MAIN_MENU_SCREEN_SCENE.instantiate()
	main_menu_node.size = Vector2(1920, 1080)
	get_node("/root/Root").add_child(main_menu_node)

	queue_free()
