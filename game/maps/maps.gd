extends Node2D

@onready var paused_alert_label: RichTextLabel = $"MapUI/GamePausedAlertLabel"
var no_money_label: Label

func _ready() -> void:
	EventBus.pause_event.connect(_on_pause)
	EventBus.not_enough_money.connect(display_no_money_warning)
	no_money_label = $"MapUI/NoMoneyWarning"
	no_money_label.visible = false

	# Pause initially until user starts
	_on_pause()


func _on_pause() -> void:
	if process_mode == Node.PROCESS_MODE_DISABLED:
		set_deferred("process_mode", Node.PROCESS_MODE_INHERIT)
		paused_alert_label.visible = false
	else:
		set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
		paused_alert_label.visible = true


func display_no_money_warning() -> void:
	no_money_label.visible = true
	var timer := Timer.new()
	timer.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = 1.3
	timer.timeout.connect(hide_no_money_warning)
	timer.start()


func hide_no_money_warning() -> void:
	no_money_label.visible = false
