extends Node2D

@onready var pause_alerter = $PauseUnpauseAlerter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_alerter.connect("pause_event", handle_pause)


func handle_pause() -> void:
	if process_mode == Node.PROCESS_MODE_DISABLED:
		process_mode = Node.PROCESS_MODE_INHERIT
	else:
		process_mode = Node.PROCESS_MODE_DISABLED
