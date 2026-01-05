extends Area2D

@onready var explosion_sfx: AudioStreamPlayer = $ExplosionSFX
var death_timer: Timer
var damage: float
var attack_type := GameTypes.AttackType.Explosive

func _ready() -> void:
	start_death_timer()
	await get_tree().physics_frame
	damage_enemies_in_radius()


func damage_enemies_in_radius() -> void:
	for cur_enemy in get_overlapping_bodies():
		if not cur_enemy.is_in_group("enemies"):
			continue
		if cur_enemy.died == true:
			continue

		cur_enemy.take_damage(self.damage, attack_type)
		explosion_sfx.play()


func start_death_timer() -> void:
	death_timer = Timer.new()
	add_child(death_timer)
	death_timer.wait_time = 0.7
	death_timer.start()
	death_timer.timeout.connect(queue_free)
