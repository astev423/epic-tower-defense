extends Node
class_name PauseUnpause

var enemy_spawner
var parent: Node2D

signal pause_event()

## Always let this run no matter what
func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	enemy_spawner.connect("wave_over", pause_event.emit)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("spacebar"):
		pause_event.emit()
