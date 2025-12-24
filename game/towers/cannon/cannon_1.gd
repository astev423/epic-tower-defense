extends Node2D

"""
This attacks a random enemy while enemies are in its range. Timer calls each time it does an attack.
All relevant variables are the consts below
"""

const ATTACKS_PER_SECOND = 1
const TOWER_DAMAGE = 2.5
const ATTACK_RANGE = 20

@onready var attack_timer: Timer = $"AttackTimer"
@onready var enemies_in_range := {}
@onready var attack_range_display: Sprite2D = $"AttackRangeDisplay"
var cannonball1 = preload("res://game/towers/cannon/cannonball1.tscn")


func _ready() -> void:
	attack_range_display.visible = false
	attack_timer.wait_time = 1. / ATTACKS_PER_SECOND
	attack_timer.timeout.connect(attack_enemy)


func attack_enemy() -> void:
	if enemies_in_range.is_empty():
		attack_timer.stop()
		return

	print("attacking")
	var cur_enemy: CharacterBody2D = enemies_in_range.keys().pick_random()
	cur_enemy.take_damage(TOWER_DAMAGE)


func _on_attack_range_area_body_entered(body: Node2D) -> void:
	enemies_in_range[body] = true
	# Attack once on enter so we don't have to wait for timer
	attack_enemy()
	attack_timer.start()


func _on_attack_range_area_body_exited(body: Node2D) -> void:
	enemies_in_range.erase(body)
