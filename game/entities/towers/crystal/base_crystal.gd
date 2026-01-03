extends "res://game/entities/towers/base_tower.gd"


## Hacky solution because pausing resets overlapping bodies sometimes, maybe manually calculate
## if enemy is valid and in range instead


const SKIP_FRAMES_AFTER_UNPAUSE := 2
const MISS_FRAMES_TO_CLEAR := 3

@onready var beam: Line2D = $Beam
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var enemy_locked_on_to: CharacterBody2D
var charging_timer: Timer
var was_paused := false
var skip_after_unpause := 0
var miss_frames := 0

func _ready() -> void:
	set_up_timer()
	super._ready()


func _physics_process(delta: float) -> void:
	var paused := get_tree().paused
	if paused:
		was_paused = true
		return

	if was_paused:
		was_paused = false
		skip_after_unpause = SKIP_FRAMES_AFTER_UNPAUSE
		miss_frames = 0
		return

	if skip_after_unpause > 0:
		skip_after_unpause -= 1
		return

	if not is_instance_valid(enemy_locked_on_to):
		try_finding_enemy_to_lock_on_to()
		return

	try_shooting_enemy(delta)
	if is_instance_valid(enemy_locked_on_to):
		look_at(enemy_locked_on_to.global_position)
		rotation += deg_to_rad(90)


func try_finding_enemy_to_lock_on_to() -> void:
	set_tower_idle()

	for cur_enemy in attack_range_area.get_overlapping_bodies():
		if not cur_enemy.is_in_group("enemies"):
			continue

		enemy_locked_on_to = cur_enemy
		charging_timer.start()
		animated_sprite.play("charging")
		miss_frames = 0
		return


func set_tower_idle() -> void:
	animated_sprite.play("default")
	is_shooting = false
	beam.visible = false
	enemy_locked_on_to = null


func try_shooting_enemy(delta: float) -> void:
	if not enemy_still_in_range():
		set_tower_idle()
		return

	if not is_shooting:
		beam.visible = false
		return

	attack_enemy_locked_on_to(delta)


func enemy_still_in_range() -> bool:
	if not is_instance_valid(enemy_locked_on_to):
		return false

	if enemy_locked_on_to in attack_range_area.get_overlapping_bodies():
		miss_frames = 0
		return true

	miss_frames += 1
	if miss_frames < MISS_FRAMES_TO_CLEAR:
		return true

	return false


func allow_shooting() -> void:
	animated_sprite.play("shooting")
	is_shooting = true


func attack_enemy_locked_on_to(delta: float) -> void:
	beam.visible = true
	var end_point := to_local(enemy_locked_on_to.global_position)
	beam.points = PackedVector2Array([Vector2.ZERO, end_point])
	enemy_locked_on_to.take_damage(stats.tower_damage)


func set_up_timer() -> void:
	charging_timer = Timer.new()
	add_child(charging_timer)
	charging_timer.wait_time = 2
	charging_timer.timeout.connect(allow_shooting)
	charging_timer.one_shot = true
