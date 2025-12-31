extends Node2D

@onready var tower_placement_manager: Node2D = $"../TowerPlacementManager"
@onready var tower_info_label: RichTextLabel = $"TowerInfo/RichTextLabel"
@onready var upgrade_cost_label: RichTextLabel = $"UpgradeTower/RichTextLabel"
@onready var tower_scenes: TowerScenes = TowerScenes.new()
var current_tower_highlighted: Node2D = null
var current_highlighted_tower_type: GameTypes.TowerType

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("tower_clicked_on", handle_user_click_on_tower)
	# Allow upgrading towers while paused
	process_mode = Node.PROCESS_MODE_ALWAYS


func _on_upgrade_tower_button_pressed() -> void:
	if current_tower_highlighted.upgrade_cost == "MAX":
		return

	# ask money manager if we have enough money, if success then despawn old tower and instantiate new one
	var success = GameState.attempt_buying_tower(int(current_tower_highlighted.upgrade_cost))
	if not success:
		return

	despawn_old_spawn_upgraded_tower()


func _input(event) -> void:
	if event.is_action_pressed("esc"):
		unhighlight_tower()
		self.visible = false


func handle_user_click_on_tower(tower) -> void:
	attempt_highlight_tower_clicked_on(tower)
	attempt_display_tower_info(tower)


func despawn_old_spawn_upgraded_tower() -> void:
	var upgraded_tower
	if current_tower_highlighted.upgrade_cost == "200":
		upgraded_tower = tower_scenes.CANNON_2_SCENE.instantiate()
	if current_tower_highlighted.upgrade_cost == "800":
		upgraded_tower = tower_scenes.CANNON_3_SCENE.instantiate()

	# Add new tower and free old one
	get_parent().add_child(upgraded_tower)
	upgraded_tower.global_position = current_tower_highlighted.global_position
	current_tower_highlighted.queue_free()
	attempt_highlight_tower_clicked_on(upgraded_tower)
	update_display_tower_info(upgraded_tower)


func attempt_highlight_tower_clicked_on(tower) -> void:
	# Unhighlight previous tower if it was highlighted and we clicked on a NEW tower
	if current_tower_highlighted != null and current_tower_highlighted != tower:
		current_tower_highlighted.attack_range_display.visible = false

	if tower.attack_range_display.visible:
		tower.attack_range_display.visible = false
		current_tower_highlighted = null
	else:
		tower.attack_range_display.visible = true
		current_tower_highlighted = tower


func attempt_display_tower_info(tower) -> void:
	if self.visible and current_tower_highlighted != tower:
		self.visible = false
		return

	self.visible = true
	update_display_tower_info(tower)


func update_display_tower_info(tower) -> void:
	tower_info_label.text = "Damage: %s   Attack Speed: %s \nProjectile Speed: %s" % [
		tower.tower_damage,
		tower.attacks_per_second,
		tower.projectile_speed
	]
	upgrade_cost_label.text = "Upgrade cost: %s" % tower.upgrade_cost


func unhighlight_tower() -> void:
	# Can't set fields on a null instance
	if current_tower_highlighted == null:
		return

	current_tower_highlighted.attack_range_display.visible = false
	current_tower_highlighted = null
