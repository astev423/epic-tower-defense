extends Node2D

@onready var tower_upgrade_manager: Node2D = $"../TowerUpgradeManager"
@onready var tower_cost_info: Control = $TowerCostInfo
@onready var tower_cost_info_label: RichTextLabel = $TowerCostInfo/RichTextLabel
var tile_map_layer: TileMapLayer
var held_tower_node: Node2D = null
var used_tiles: Dictionary[Vector2i, Node2D] = {}

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


## Event driven actions instead of polling
func _input(event: InputEvent) -> void:
	if is_instance_valid(held_tower_node) and event is InputEventMouseMotion:
		make_tower_follow_mouse()

	if event.is_action_pressed("left_mouse"):
		try_placing_tower_on_grid()
	elif event.is_action_pressed("right_mouse"):
		try_delete_tower_on_grid()
	elif event.is_action_pressed("esc"):
		try_deselect_held_tower()


func _on_select_cannon_pressed() -> void:
	create_moveable_tower_for_ui(GameTypes.TowerType.CANNON1)


func _on_select_rocket_launcher_pressed() -> void:
	create_moveable_tower_for_ui(GameTypes.TowerType.ROCKET_LAUNCHER1)


func _on_select_crossbow_pressed() -> void:
	create_moveable_tower_for_ui(GameTypes.TowerType.CROSSBOW1)


func _on_select_crystal_pressed() -> void:
	create_moveable_tower_for_ui(GameTypes.TowerType.CRYSTAL1)


func create_moveable_tower_for_ui(tower_clicked_on: GameTypes.TowerType) -> void:
	# Delete old UI tower if we clicked on a new one
	if is_instance_valid(held_tower_node):
		free_held_tower()

	held_tower_node = get_tower_instantiation(tower_clicked_on)
	get_parent().add_child(held_tower_node)
	held_tower_node.global_position = get_global_mouse_position()
	# This cannon is for dragging only, so disable process logic
	held_tower_node.process_mode = Node.PROCESS_MODE_DISABLED
	held_tower_node.attack_range_display.visible = true

	update_ui_for_dragged_tower()


func update_ui_for_dragged_tower() -> void:
	# Unhighlight tower to hide the stats of previous highlighted since we selected new one
	tower_upgrade_manager.unhighlight_tower()
	show_tower_cost_info()


func try_placing_tower_on_grid() -> void:
	var mouse_pos := get_global_mouse_position()
	if (mouse_pos.x > GameConstants.TILE_SIZE * GameConstants.NUM_HORIZONTAL_TILES
			or mouse_pos.y > GameConstants.TILE_SIZE * GameConstants.NUM_VERTICAL_TILES
			or not is_instance_valid(held_tower_node)):
		return

	var cell_pos := tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
	var is_tile_placeable: bool = tile_map_layer.get_cell_tile_data(cell_pos).get_custom_data("placeable")
	if is_tile_placeable and not is_tile_occupied(cell_pos):
		var success := GameState.try_buying_tower(held_tower_node.tower_cost)
		if not success:
			return

		place_active_tower(cell_pos)


func free_held_tower() -> void:
	held_tower_node.queue_free()
	tower_cost_info.visible = false


func get_tower_instantiation(held_tower_type: GameTypes.TowerType) -> Node2D:
	var tower_node: Node2D

	if held_tower_type == GameTypes.TowerType.CANNON1:
		tower_node = TowerScenes.CANNON_1_SCENE.instantiate()
	elif held_tower_type == GameTypes.TowerType.ROCKET_LAUNCHER1:
		tower_node = TowerScenes.ROCKET_LAUNCHER_1_SCENE.instantiate()
	elif held_tower_type == GameTypes.TowerType.CROSSBOW1:
		tower_node = TowerScenes.CROSSBOW_1_SCENE.instantiate()
	elif held_tower_type == GameTypes.TowerType.CRYSTAL1:
		tower_node = TowerScenes.CRYSTAL_1_SCENE.instantiate()
	else:
		print("trying to get tower that doesn't exist")
		tower_node = null

	return tower_node


func place_active_tower(cell_position: Vector2i) -> void:
	var new_tower := get_tower_instantiation(held_tower_node.type)
	get_parent().add_child(new_tower)
	new_tower.global_position = cell_position * 64 + Vector2i(32, 32)
	used_tiles[cell_position] = new_tower

	new_tower.clickbox.visible = true
	new_tower.can_fire = true


func is_tile_occupied(cell_pos: Vector2i) -> bool:
	return used_tiles.has(cell_pos)


func try_delete_tower_on_grid() -> void:
	var cell_pos := tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
	if not is_tile_occupied(cell_pos):
		return

	var tower: Node2D = used_tiles[cell_pos]
	GameState.add_money(tower.tower_cost / 2)
	tower.queue_free()
	used_tiles.erase(cell_pos)
	tower_upgrade_manager.unhighlight_tower()


func make_tower_follow_mouse() -> void:
	held_tower_node.global_position = get_global_mouse_position()


func try_deselect_held_tower() -> void:
	tower_cost_info.visible = false

	if is_instance_valid(held_tower_node):
		held_tower_node.queue_free()


func show_tower_cost_info() -> void:
	tower_cost_info_label.text = "Tower Cost: %s" % held_tower_node.tower_cost
	tower_cost_info.visible = true
