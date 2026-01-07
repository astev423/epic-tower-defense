extends "res://game/entities/enemies/base_enemy.gd"

@onready var death_explosion_sprite: Sprite2D = $DeathExplosionSprite
@onready var death_explosion_sound: AudioStreamPlayer = $DeathExplosionSound

func _on_death() -> void:
	if died:
		return

	EventBus.enemy_died.emit()
	GameState.add_money(stats.money_awarded_if_killed)
	died = true
	death_sound.play()
	_shake_sprite_while(death_sound.stream.get_length(), 6.0, 60.0)
	set_physics_process(false)
	await death_sound.finished
	sprite.hide()
	death_explosion_sprite.show()
	death_explosion_sound.play()
	await death_explosion_sound.finished
	queue_free()


func _shake_sprite_while(duration: float, strength := 6.0, hz := 60.0) -> void:
	var base_pos := sprite.position
	var step := 1.0 / hz
	var t := 0.0

	while t < duration:
		sprite.position = base_pos + Vector2(
			randf_range(-strength, strength),
			randf_range(-strength, strength)
		)
		await get_tree().create_timer(step).timeout
		t += step

	sprite.position = base_pos
