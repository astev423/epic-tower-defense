extends Node2D
## This is the abstract base class for all towers, towers change their rotation to look at enemies when
## they are in radius, spawn cannonballs with direction to travel, detect when enemies exit and enter
## and keep track of them via a dictionary, and show their range and stats when their are clicked on
##
## When making a new tower all you need to do is extend this then define the tower range, attack damage,
## attacks per second, and the cannonball scene it will use. In the GUI define the sprites, range, etc

@onready var attack_timer: Timer = $"AttackTimer"
@onready var enemies_in_range := {}
@onready var attack_range_display: Sprite2D = $"AttackRangeDisplay"
@onready var attack_range_area_hitbox: CollisionShape2D = $"AttackRangeArea/CollisionShape2D"
@onready var cur_enemy: CharacterBody2D = null

# Stats, these change depending on the cannon
var tower_scene: PackedScene = null
var attacks_per_second: float
var tower_damage: float
var tower_range
var tower_cost
var upgrade_cost

signal tower_clicked_on()

func _ready() -> void:
	attack_range_display.visible = false
	attack_timer.wait_time = 1. / attacks_per_second
	attack_timer.timeout.connect(shoot_cannonball_at_enemy)


## Process only shows final phase of things, so if we change rotation multiple times no artifacts occur
func _process(delta) -> void:
	if cur_enemy != null:
		look_at(cur_enemy.global_position)
		rotation += deg_to_rad(90)


func set_stats(_attacks_per_second: float, _tower_damage: float, _tower_cost: float,
		_tower_range: float, _upgrade_cost: String) -> void:
	attacks_per_second = _attacks_per_second
	tower_damage = _tower_damage
	tower_cost = _tower_cost
	tower_range = _tower_range
	upgrade_cost = _upgrade_cost


func shoot_cannonball_at_enemy() -> void:
	if enemies_in_range.is_empty():
		attack_timer.stop()
		cur_enemy = null
		return

	cur_enemy = enemies_in_range.keys().pick_random()
	var cannonball = tower_scene.instantiate()
	get_parent().add_child(cannonball)
	cannonball.global_position = global_position
	cannonball.direction = (cur_enemy.global_position - cannonball.global_position).normalized()
	cannonball.damage = tower_damage


func _on_attack_range_area_body_entered(body: Node2D) -> void:
	enemies_in_range[body] = true
	# If first enemy enter shoot instantly, otherwise wait
	if enemies_in_range.size() == 1:
		call_deferred("shoot_cannonball_at_enemy")
		attack_timer.start()


func _on_attack_range_area_body_exited(body: Node2D) -> void:
	enemies_in_range.erase(body)


func _on_display_tower_info_clickbox_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		tower_clicked_on.emit(self)
