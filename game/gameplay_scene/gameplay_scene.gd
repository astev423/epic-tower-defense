extends Node2D

enum GameSpeed {
	PAUSED,
	ONE_TIMES,
	TWO_TIMES
}

var current_game_speed: GameSpeed
var level_node: Node2D


func _ready() -> void:
	EventBus.pause_game.connect(pause_game)
	EventBus.spacebar_pressed.connect(change_game_timescale)
	pause_game()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("spacebar"):
		EventBus.spacebar_pressed.emit()


func pause_game() -> void:
	level_node.process_mode = Node.PROCESS_MODE_DISABLED
	EventBus.game_timescale_changed.emit("PAUSED")
	current_game_speed = GameSpeed.PAUSED


func change_game_timescale() -> void:
	if current_game_speed == GameSpeed.PAUSED:
		level_node.process_mode = Node.PROCESS_MODE_INHERIT
		current_game_speed = GameSpeed.ONE_TIMES
		Engine.time_scale = 1.0
		EventBus.game_timescale_changed.emit("1X")
	elif current_game_speed == GameSpeed.ONE_TIMES:
		level_node.process_mode = Node.PROCESS_MODE_INHERIT
		current_game_speed = GameSpeed.TWO_TIMES
		Engine.time_scale = 2.0
		EventBus.game_timescale_changed.emit("2X")
	else:
		level_node.process_mode = Node.PROCESS_MODE_DISABLED
		current_game_speed = GameSpeed.PAUSED
		EventBus.game_timescale_changed.emit("PAUSED")
