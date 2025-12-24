extends Node2D

"""
This attacks a random enemy while enemies are in its range. Timer calls each time it does an attack.
All relevant variables are the consts below
"""

const ATTACKS_PER_SECOND = 1
const TOWER_DAMAGE = 2.5
const ATTACK_RANGE = 20
const CANNONBALL1_SCENE = preload("res://game/towers/cannon/cannonball1.tscn")

@onready var attack_timer: Timer = $"AttackTimer"
@onready var enemies_in_range := {}
@onready var attack_range_display: Sprite2D = $"AttackRangeDisplay"
@onready var cur_enemy: CharacterBody2D = null


func _ready() -> void:
	attack_range_display.visible = false
	attack_timer.wait_time = 1. / ATTACKS_PER_SECOND
	attack_timer.timeout.connect(shoot_cannonball_at_enemy)


## Process only shows final phase of things, so if we change rotation multiple times no artifacts occur
func _process(delta) -> void:
	if cur_enemy != null:
		look_at(cur_enemy.global_position)
		rotation += deg_to_rad(90)


func shoot_cannonball_at_enemy() -> void:
	if enemies_in_range.is_empty():
		attack_timer.stop()
		cur_enemy = null
		return

	cur_enemy = enemies_in_range.keys().pick_random()
	var cannonball = CANNONBALL1_SCENE.instantiate()
	get_tree().root.add_child(cannonball)
	cannonball.global_position = global_position
	cannonball.direction = (cur_enemy.global_position - cannonball.global_position).normalized()


func _on_attack_range_area_body_entered(body: Node2D) -> void:
	enemies_in_range[body] = true
	# Attack once on enter so we don't have to wait for timer, defer since we can't do physics in here
	call_deferred("shoot_cannonball_at_enemy")
	attack_timer.start()


func _on_attack_range_area_body_exited(body: Node2D) -> void:
	enemies_in_range.erase(body)
