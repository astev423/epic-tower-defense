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
@onready var projectile_sound: AudioStreamPlayer = $ProjectileSound
@export var stats: TowerStats
var can_fire: bool
var is_shooting: bool


func _ready() -> void:
	# By default tower is a dud, these falses get set to true when placed so tower can do stuff
	attack_range_display.visible = false
	clickbox.visible = false
	attack_timer.wait_time = 1. / stats.attacks_per_second
	attack_timer.timeout.connect(allow_tower_to_shoot)


func _physics_process(delta: float) -> void:
	for cur_enemy in attack_range_area.get_overlapping_bodies():
		if not cur_enemy.is_in_group("enemies"):
			continue
		if cur_enemy.died == true:
			continue

		look_at(cur_enemy.global_position)
		rotation += deg_to_rad(90)

		if can_fire:
			spawn_projectile(cur_enemy)
			projectile_sound.play()
			can_fire = false
			is_shooting = true
			attack_timer.start()
		else:
			is_shooting = false

		break


func _on_display_tower_info_clickbox_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		EventBus.tower_clicked_on.emit(self)


func allow_tower_to_shoot() -> void:
	can_fire = true
	attack_timer.stop()


func spawn_projectile(enemy_to_shoot_at: CharacterBody2D) -> void:
	var projectile_node: Area2D = stats.projectile_scene.instantiate()
	get_parent().add_child(projectile_node)
	projectile_node.global_position = global_position
	projectile_node.direction = (enemy_to_shoot_at.global_position - projectile_node.global_position).normalized()
	projectile_node.damage = stats.tower_damage
	projectile_node.projectile_speed = stats.projectile_speed
	projectile_node.attack_type = stats.attack_type
