extends Node
class_name PauseUnpause


## Always let this run no matter what
func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	EventBus.connect("wave_over", EventBus.pause_event.emit)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("spacebar"):
		EventBus.pause_event.emit()
