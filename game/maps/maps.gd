extends Node2D

@onready var pause_alerter = $"PauseUnpauseAlerter"

func _ready() -> void:
	pause_alerter.connect("pause_event", handle_pause)
	# Pause initially until user starts
	handle_pause()


func handle_pause() -> void:
	if process_mode == Node.PROCESS_MODE_DISABLED:
		print_debug("unpausing")
		set_deferred("process_mode", Node.PROCESS_MODE_INHERIT)
	else:
		set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
		print_debug("pausing")
