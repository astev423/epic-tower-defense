extends Node
class_name PauseUnpause

var parent: Node2D

signal pause_event()

## Always let this run no matter what
func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS


## Little bit of coupling
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spacebar"):
		pause_event.emit()
