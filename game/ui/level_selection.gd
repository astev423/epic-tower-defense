extends Control

const MAPS_SCENE = preload("res://game/gameplay_scene/gameplay_scene.tscn")
const NUM_LIVES_FOR_WAVE := 300

@onready var check: Sprite2D = $Checkmark
@onready var x: Sprite2D = $X
@onready var change_wave_num: LineEdit = $ChangeWaveNum
var starting_wave_num: int
var is_unlimited_money_mode: bool
var map_node: Node2D
var level_chosen_scene: PackedScene
var level_node: Node2D


func _ready() -> void:
	starting_wave_num = 1
	is_unlimited_money_mode = false
	map_node = MAPS_SCENE.instantiate()


func _on_select_dunes_button_pressed() -> void:
	level_chosen_scene = load("res://game/gameplay_scene/levels/dunes.tscn")
	spawn_level()


func _on_select_plains_button_pressed() -> void:
	level_chosen_scene = load("res://game/gameplay_scene/levels/plains.tscn")
	spawn_level()


func _on_select_dungeon_button_pressed() -> void:
	level_chosen_scene = load("res://game/gameplay_scene/levels/dungeon.tscn")
	spawn_level()


func _on_select_unlimited_money_button_pressed() -> void:
	if is_unlimited_money_mode:
		check.visible = false
		x.visible = true
		is_unlimited_money_mode = false
	else:
		check.visible = true
		x.visible = false
		is_unlimited_money_mode = true


func _on_line_edit_text_changed(new_text: String) -> void:
	if not new_text.is_valid_int() or int(new_text) > 40 or int(new_text) < 1:
		change_wave_num.text = str(starting_wave_num)
		return

	starting_wave_num = int(new_text)


func spawn_level() -> void:
	GameState.set_variables(NUM_LIVES_FOR_WAVE, get_starting_money(), starting_wave_num)
	add_level_to_scene()

	var tower_placement_manager := map_node.get_node("GameplayUI/TowerPlacementManager")
	tower_placement_manager.tile_map_layer = level_node.get_node("TileMapLayer")

	get_node("/root/GameRoot").add_child(map_node)
	get_node("/root/GameRoot/MenuBGM").stop()

	queue_free()


func add_level_to_scene() -> void:
	level_node = level_chosen_scene.instantiate()
	map_node.add_child(level_node)
	map_node.move_child(level_node, 0)
	map_node.level_node = level_node



func get_starting_money() -> int:
	if is_unlimited_money_mode:
		return 9999999999

	return WaveInfo.starting_money_at_given_wave[starting_wave_num]
