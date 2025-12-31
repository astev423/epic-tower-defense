extends Node
class_name PauseUnpause


## Always let this run no matter what
func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("spacebar"):
		EventBus.pause_event.emit()
