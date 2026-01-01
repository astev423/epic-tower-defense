extends Area2D

var death_timer: Timer
var damage: float

func _ready() -> void:
	death_timer = Timer.new()
	add_child(death_timer)
	death_timer.wait_time = 0.7
	death_timer.start()
	death_timer.timeout.connect(queue_free)
	await get_tree().physics_frame
	damage_enemies_in_radius()


func damage_enemies_in_radius() -> void:
	for cur_enemy in self.get_overlapping_bodies():
		if not cur_enemy.is_in_group("enemies"):
			continue

		cur_enemy.take_damage(self.damage)
