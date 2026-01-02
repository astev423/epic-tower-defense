extends Node2D
## This is the abstract base class for all towers, towers change their rotation to look at enemies when
## they are in radius. It checks at given timer interval if enemy is in range, then tracks it
##
## When making a new tower all you need to do is extend this then define the tower range, attack damage,
## attacks per second, and the cannonball scene it will use. In the GUI define the sprites, range, etc

@onready var attack_timer: Timer = $"AttackTimer"
@onready var enemies_in_range := {}
@onready var attack_range_display: Sprite2D = $"AttackRangeDisplay"
@onready var attack_range_area_hitbox: CollisionShape2D = $"AttackRangeArea/CollisionShape2D"
@onready var attack_range_area: Area2D = $"AttackRangeArea"
@onready var clickbox: Area2D = $DisplayTowerInfoClickbox
var can_fire: bool
var is_shooting: bool

# Stats, these change depending on the cannon
var projectile_scene: PackedScene = null
var attacks_per_second: float
var tower_damage: float
var projectile_speed: int
var tower_cost: int
var upgrade_cost: String
var type: GameTypes.TowerType


func _ready() -> void:
	# By default tower is a dud, these falses get set to true when placed so tower can do stuff
	attack_range_display.visible = false
	clickbox.visible = false
	can_fire = true
	attack_timer.wait_time = 1. / attacks_per_second
	attack_timer.timeout.connect(allow_tower_to_shoot)


## Look at an enemy if it exists and shoot if cooldown done
func _physics_process(delta: float) -> void:
	# Get bodies not areas as enemies are charbody2d
	for cur_enemy in attack_range_area.get_overlapping_bodies():
		if not cur_enemy.is_in_group("enemies"):
			continue

		look_at(cur_enemy.global_position)
		rotation += deg_to_rad(90)

		if can_fire:
			var projectile_node: Area2D = projectile_scene.instantiate()
			get_parent().add_child(projectile_node)
			projectile_node.global_position = global_position
			projectile_node.direction = (cur_enemy.global_position - projectile_node.global_position).normalized()
			projectile_node.damage = tower_damage
			projectile_node.projectile_speed = projectile_speed
			can_fire = false
			is_shooting = true
			attack_timer.start()

		break


func _on_display_tower_info_clickbox_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		EventBus.tower_clicked_on.emit(self)


func set_stats(_attacks_per_second: float, _tower_damage: float, _tower_cost: int,
		_projectile_speed: int, _upgrade_cost: String) -> void:
	attacks_per_second = _attacks_per_second
	tower_damage = _tower_damage
	tower_cost = _tower_cost
	upgrade_cost = _upgrade_cost
	projectile_speed = _projectile_speed


func allow_tower_to_shoot() -> void:
	can_fire = true
	attack_timer.stop()
