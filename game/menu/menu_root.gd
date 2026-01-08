extends Control



# PATHS INSTEAD OF PRELOAD TO PREVENT RECURSION, THIS IS THE BASE CASE RIGHT HERE
@export_file("*.tscn") var home_menu_screen_path: String
@export_file("*.tscn") var level_selection_screen_path: String
@export_file("*.tscn") var menu_tutorial_screen_path: String
@export_file("*.tscn") var victory_screen_path: String
@export_file("*.tscn") var game_over_screen_path: String
var current_screen_type: GameTypes.MenuScreen
var current_screen_node: Control
var screen_nodes_cache: Dictionary[GameTypes.MenuScreen, Control]
var screen_paths: Dictionary[GameTypes.MenuScreen, String]


func _ready() -> void:
	EventBus.change_menu_screen_button_pressed.connect(_on_change_menu_screen_button_pressed)
	EventBus.starting_new_game.connect(queue_free)
	screen_paths = {
		GameTypes.MenuScreen.HOME: home_menu_screen_path,
		GameTypes.MenuScreen.LEVEL_SELECTION: level_selection_screen_path,
		GameTypes.MenuScreen.TUTORIAL: menu_tutorial_screen_path,
		GameTypes.MenuScreen.VICTORY_SCREEN: victory_screen_path,
		GameTypes.MenuScreen.GAME_OVER: game_over_screen_path,
	}
	change_menu_screen_to(GameTypes.MenuScreen.HOME)



func _on_change_menu_screen_button_pressed(screen_pressed: GameTypes.MenuScreen) -> void:
	change_menu_screen_to(screen_pressed)


func change_menu_screen_to(screen_to_change_to: GameTypes.MenuScreen) -> void:
	if is_instance_valid(current_screen_node):
		current_screen_node.process_mode = Node.PROCESS_MODE_DISABLED
		current_screen_node.hide()

	if not screen_nodes_cache.has(screen_to_change_to):
		screen_nodes_cache[screen_to_change_to] = load(screen_paths[screen_to_change_to]).instantiate()

	current_screen_type = screen_to_change_to
	current_screen_node = screen_nodes_cache[screen_to_change_to]
	current_screen_node.process_mode = Node.PROCESS_MODE_INHERIT
	current_screen_node.show()
	if not current_screen_node.is_inside_tree():
		add_child(current_screen_node)
