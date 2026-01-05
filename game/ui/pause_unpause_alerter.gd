extends Node
class_name PauseUnpause


func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("spacebar"):
		EventBus.change_game_timescale.emit()
