extends Node2D
## This is a very important class for managing selection, placement, and deletion of towers

const MAP_CONSTANTS = preload("res://game/maps/levels.gd")
const IS_PLACEABLE := "placeable"
const TOWER_GROUP := "TOWER_GROUP"

@onready var tower_scenes: TowerScenes = TowerScenes.new()
@onready var select_cannon: Button = $SelectCannon
@onready var tower_upgrade_manager: Node2D = $"../TowerUpgradeManager"
@onready var select_rocket_launcher: Button = $SelectRocketLauncher
@onready var tower_cost_info: Control = $TowerCostInfo
@onready var tower_cost_info_label: RichTextLabel = $TowerCostInfo/RichTextLabel
var tile_map_layer: TileMapLayer
var held_tower_type := GameTypes.TowerType.NONE
var held_tower_node: Node2D = null
var used_tiles: Dictionary = {}

func _ready() -> void:
	select_cannon.pressed.connect(Callable(self, "create_moveable_tower_for_ui").bind(GameTypes.TowerType.CANNON1))
	select_rocket_launcher.pressed.connect(Callable(self, "create_moveable_tower_for_ui").bind(GameTypes.TowerType.ROCKET_LAUNCHER1))
	process_mode = Node.PROCESS_MODE_ALWAYS


## This uses mouse events instead of polling to determine how to modify towers
func _input(event: InputEvent) -> void:
	if is_instance_valid(held_tower_node) and event is InputEventMouseMotion:
		make_tower_follow_mouse()

	if event.is_action_pressed("left_mouse"):
		attempt_placing_tower_on_grid()
	elif event.is_action_pressed("right_mouse"):
		attempt_delete_tower_on_grid()
	elif event.is_action_pressed("esc"):
		attempt_deselect_held_tower()


func create_moveable_tower_for_ui(tower_clicked_on: GameTypes.TowerType) -> void:
	# Delete old UI tower if we clicked on a new one
	if held_tower_node != null:
		held_tower_node.queue_free()
		tower_cost_info.visible = false

	held_tower_type = tower_clicked_on
	held_tower_node = get_tower_instantiation()
	get_parent().add_child(held_tower_node)
	held_tower_node.global_position = get_global_mouse_position()
	# This cannon is for dragging only, so disable process logic
	held_tower_node.process_mode = Node.PROCESS_MODE_DISABLED
	held_tower_node.attack_range_display.visible = true
	tower_upgrade_manager.unhighlight_tower()
	show_tower_cost_info()


func attempt_placing_tower_on_grid() -> void:
	# Can't place on the tower selection UI and it must be currently held
	var mouse_pos := get_global_mouse_position()
	if (mouse_pos.x > MAP_CONSTANTS.TILE_SIZE * MAP_CONSTANTS.NUM_HORIZONTAL_TILES
			or mouse_pos.y > MAP_CONSTANTS.TILE_SIZE * MAP_CONSTANTS.NUM_VERTICAL_TILES
			or held_tower_node == null):
		return

	var cell_position := tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
	var is_placeable: bool = tile_map_layer.get_cell_tile_data(cell_position).get_custom_data("placeable")

	if is_placeable and not used_tiles.has(cell_position):
		var success := GameState.attempt_buying_tower(held_tower_node.tower_cost)
		if not success:
			return

		place_tower(cell_position)


func get_tower_instantiation() -> Node2D:
	var tower_node: Node2D

	if held_tower_type == GameTypes.TowerType.CANNON1:
		tower_node = tower_scenes.CANNON_1_SCENE.instantiate()
	elif held_tower_type == GameTypes.TowerType.ROCKET_LAUNCHER1:
		tower_node = tower_scenes.ROCKET_LAUNCHER_1_SCENE.instantiate()
	else:
		tower_node = null

	return tower_node


func place_tower(cell_position: Vector2i) -> void:
	var new_tower := get_tower_instantiation()
	get_parent().add_child(new_tower)
	new_tower.global_position = cell_position * 64 + Vector2i(32, 32)
	used_tiles[cell_position] = new_tower
	new_tower.clickbox.visible = true
	new_tower.add_to_group(TOWER_GROUP)


## Free tower if it exists and mark tiles it occupied as placeable again
func attempt_delete_tower_on_grid() -> void:
	var cell_position := tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
	if used_tiles.has(cell_position):
		var tower: Node2D = used_tiles[cell_position]
		GameState.add_money(tower.tower_cost / 2)
		tower.queue_free()
		used_tiles.erase(cell_position)


func make_tower_follow_mouse() -> void:
	held_tower_node.global_position = get_global_mouse_position()


func attempt_deselect_held_tower() -> void:
	held_tower_type = GameTypes.TowerType.NONE
	tower_cost_info.visible = false

	if held_tower_node != null:
		held_tower_node.queue_free()
		held_tower_node = null


func show_tower_cost_info() -> void:
	tower_cost_info_label.text = "Tower Cost: %s" % held_tower_node.tower_cost
	tower_cost_info.visible = true
