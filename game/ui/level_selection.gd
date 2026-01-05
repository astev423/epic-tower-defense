extends Control

const MAPS_SCENE = preload("res://game/gameplay_scene/gameplay_scene.tscn")
const NUM_LIVES_FOR_WAVE := 300

@onready var check: Sprite2D = $Checkmark
@onready var x: Sprite2D = $X
@onready var change_wave_num: LineEdit = $ChangeWaveNum
var starting_wave_num: int
var is_unlimited_money_mode: bool
var map_node: Node2D
var map_user_clicked: GameConstants.Levels
var level_chosen_scene: PackedScene


func _ready() -> void:
	starting_wave_num = 1
	is_unlimited_money_mode = false
	map_node = MAPS_SCENE.instantiate()


func _on_select_dunes_button_pressed() -> void:
	map_user_clicked = GameConstants.Levels.DUNES
	spawn_level()


func _on_select_plains_button_pressed() -> void:
	map_user_clicked = GameConstants.Levels.PLAINS
	spawn_level()


func _on_select_dungeon_button_pressed() -> void:
	map_user_clicked = GameConstants.Levels.DUNGEON
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
	# Text must be an int and between 1 and 40
	if not new_text.is_valid_int() or int(new_text) > 40 or int(new_text) < 1:
		change_wave_num.text = str(starting_wave_num)
		return

	starting_wave_num = int(new_text)


func spawn_level() -> void:
	set_variables_for_map_clicked()
	instantiate_map_stuff()


func set_variables_for_map_clicked() -> void:
	if map_user_clicked == GameConstants.Levels.DUNES:
		level_chosen_scene = load("res://game/gameplay_scene/levels/dunes.tscn")
	elif map_user_clicked == GameConstants.Levels.PLAINS:
		level_chosen_scene = load("res://game/gameplay_scene/levels/plains.tscn")
	elif map_user_clicked == GameConstants.Levels.DUNGEON:
		level_chosen_scene = load("res://game/gameplay_scene/levels/dungeon.tscn")
	else:
		print_debug("FATAL ERROR ON MAP SELECTION, CRASHING")
		get_tree().quit()

	GameState.set_variables(NUM_LIVES_FOR_WAVE, get_starting_money(), starting_wave_num)


func instantiate_map_stuff() -> void:
	var level_node: Node2D = level_chosen_scene.instantiate()
	map_node.add_child(level_node)

	var tower_placement_manager := map_node.get_node("GameplayUI/TowerPlacementManager")
	var tile_layer := level_node.get_node("TileMapLayer")
	tower_placement_manager.tile_map_layer = tile_layer

	get_node("/root/GameRoot").add_child(map_node)

	queue_free()


func get_starting_money() -> int:
	if is_unlimited_money_mode:
		return 9999999999

	return WaveInfo.starting_money_at_given_wave[starting_wave_num]
