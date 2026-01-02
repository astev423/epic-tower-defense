extends Node2D

@onready var tower_placement_manager: Node2D = $"../TowerPlacementManager"
@onready var tower_info_label: RichTextLabel = $"TowerInfo/RichTextLabel"
@onready var upgrade_cost_label: RichTextLabel = $"UpgradeTower/RichTextLabel"
var current_tower_highlighted: Node2D = null


func _ready() -> void:
	EventBus.tower_clicked_on.connect(_on_user_click_on_tower)
	# Allow upgrading towers while paused
	process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		unhighlight_tower()
		self.visible = false


func _on_upgrade_tower_button_pressed() -> void:
	if current_tower_highlighted.upgrade_cost == "MAX":
		return

	# ask money manager if we have enough money, if success then despawn old tower and instantiate new one
	var success := GameState.try_buying_tower(int(current_tower_highlighted.upgrade_cost))
	if not success:
		return

	despawn_old_spawn_upgraded_tower()


func _on_user_click_on_tower(tower: Node2D) -> void:
	var mouse_pos := get_global_mouse_position()
	if (mouse_pos.x > GameConstants.TILE_SIZE * GameConstants.NUM_HORIZONTAL_TILES
			or mouse_pos.y > GameConstants.TILE_SIZE * GameConstants.NUM_VERTICAL_TILES):
		return

	try_highlight_tower_clicked_on(tower)
	try_display_tower_info(tower)


func despawn_old_spawn_upgraded_tower() -> void:
	var old_tower_pos := current_tower_highlighted.global_position
	current_tower_highlighted.queue_free()

	var upgraded_tower := get_upgraded_tower_node()
	get_parent().add_child(upgraded_tower)
	upgraded_tower.global_position = old_tower_pos
	try_highlight_tower_clicked_on(upgraded_tower)
	upgraded_tower.clickbox.visible = true
	upgraded_tower.can_fire = true
	update_display_tower_info(upgraded_tower)
	var cell: Vector2i = tower_placement_manager.tile_map_layer.local_to_map(
		tower_placement_manager.tile_map_layer.to_local(upgraded_tower.global_position)
	)
	tower_placement_manager.used_tiles[cell] = upgraded_tower


func get_upgraded_tower_node() -> Node2D:
	var upgraded_tower: Node2D
	if current_tower_highlighted.type == GameTypes.TowerType.CANNON1:
		upgraded_tower = TowerScenes.CANNON_2_SCENE.instantiate()
	elif current_tower_highlighted.type == GameTypes.TowerType.CANNON2:
		upgraded_tower = TowerScenes.CANNON_3_SCENE.instantiate()
	elif current_tower_highlighted.type == GameTypes.TowerType.ROCKET_LAUNCHER1:
		upgraded_tower = TowerScenes.ROCKET_LAUNCHER_2_SCENE.instantiate()
	elif current_tower_highlighted.type == GameTypes.TowerType.ROCKET_LAUNCHER2:
		upgraded_tower = TowerScenes.ROCKET_LAUNCHER_3_SCENE.instantiate()
	elif current_tower_highlighted.type == GameTypes.TowerType.CROSSBOW1:
		upgraded_tower = TowerScenes.CROSSBOW_2_SCENE.instantiate()
	elif current_tower_highlighted.type == GameTypes.TowerType.CROSSBOW2:
		upgraded_tower = TowerScenes.CROSSBOW_3_SCENE.instantiate()
	elif current_tower_highlighted.type == GameTypes.TowerType.CRYSTAL1:
		upgraded_tower = TowerScenes.CRYSTAL_2_SCENE.instantiate()
	elif current_tower_highlighted.type == GameTypes.TowerType.CRYSTAL2:
		upgraded_tower = TowerScenes.CRYSTAL_3_SCENE.instantiate()

	return upgraded_tower


func try_highlight_tower_clicked_on(tower: Node2D) -> void:
	# Unhighlight previous tower if it was highlighted and we clicked on a NEW tower
	if current_tower_highlighted != null and current_tower_highlighted != tower:
		current_tower_highlighted.attack_range_display.visible = false

	if tower.attack_range_display.visible:
		tower.attack_range_display.visible = false
		current_tower_highlighted = null
	else:
		tower.attack_range_display.visible = true
		current_tower_highlighted = tower


func try_display_tower_info(tower: Node2D) -> void:
	if self.visible and current_tower_highlighted != tower:
		self.visible = false
		return

	self.visible = true
	update_display_tower_info(tower)


func update_display_tower_info(tower: Node2D) -> void:
	var projectile_speed
	if tower.projectile_speed >= 10000:
		projectile_speed = "INSTANT"
	else:
		projectile_speed = tower.projectile_speed

	var dps: float = tower.tower_damage * tower.attacks_per_second
	tower_info_label.text = "Damage: %s   Attack Speed: %s \nProjectile Speed: %s   DPS: %s" % [
		tower.tower_damage,
		tower.attacks_per_second,
		projectile_speed,
		dps
	]
	upgrade_cost_label.text = "Upgrade cost: %s" % tower.upgrade_cost


func unhighlight_tower() -> void:
	# Can't set fields on a null instance
	if not is_instance_valid(current_tower_highlighted):
		return

	current_tower_highlighted.attack_range_display.visible = false
	current_tower_highlighted = null
	self.visible = false
