extends Node2D

enum GameSpeed {
	PAUSED,
	ONE_TIMES,
	TWO_TIMES
}

var current_game_speed: GameSpeed


func _ready() -> void:
	EventBus.pause_game.connect(pause_game)
	EventBus.spacebar_pressed.connect(change_game_timescale)

	current_game_speed = GameSpeed.PAUSED
	process_mode = Node.PROCESS_MODE_DISABLED


func pause_game() -> void:
	set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
	EventBus.game_timescale_changed.emit("PAUSED")
	current_game_speed = GameSpeed.PAUSED


func change_game_timescale() -> void:
	if current_game_speed == GameSpeed.PAUSED:
		set_deferred("process_mode", Node.PROCESS_MODE_INHERIT)
		current_game_speed = GameSpeed.ONE_TIMES
		Engine.time_scale = 1.0
		EventBus.game_timescale_changed.emit("1X")
	elif current_game_speed == GameSpeed.ONE_TIMES:
		set_deferred("process_mode", Node.PROCESS_MODE_INHERIT)
		current_game_speed = GameSpeed.TWO_TIMES
		Engine.time_scale = 2.0
		EventBus.game_timescale_changed.emit("2X")
	else:
		set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
		current_game_speed = GameSpeed.PAUSED
		EventBus.game_timescale_changed.emit("PAUSED")
