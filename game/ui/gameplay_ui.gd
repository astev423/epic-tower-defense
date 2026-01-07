extends Control

@onready var paused_alert_label: RichTextLabel = $GamePausedAlertLabel
@onready var reduced_damage_alert_label: Label = $ReducedDamageWarning
@onready var game_speed_label: Label = $GameSpeedLabel
@onready var no_money_label: Label = $NoMoneyWarning
@export var main_menu_screen_scene: PackedScene


func _ready() -> void:
	EventBus.game_timescale_changed.connect(_on_timescale_change)
	EventBus.not_enough_money.connect(display_no_money_warning)
	EventBus.wave_25_passed.connect(display_reduced_damage_alert_label)


func _on_quit_button_pressed() -> void:
	var main_menu_node: Control = main_menu_screen_scene.instantiate()
	main_menu_node.size = Vector2(1920, 1080)
	get_node("/root/GameRoot").add_child(main_menu_node)
	get_node("/root/GameRoot/MenuBGM").play()

	get_node("/root/GameRoot/GameplayScene").queue_free()


func _on_timescale_change(new_timescale: String) -> void:
	if new_timescale == "PAUSED":
		paused_alert_label.visible = true
		game_speed_label.text = "SPEED:\nPAUSED"
	elif new_timescale == "1X":
		paused_alert_label.visible = false
		game_speed_label.text = "SPEED:\n100%"
	elif new_timescale == "2X":
		paused_alert_label.visible = false
		game_speed_label.text = "SPEED:\n200%"
	else:
		print_debug("Critical error on chaning game speed, no valid timescale found, typo likely")


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


func display_reduced_damage_alert_label() -> void:
	reduced_damage_alert_label.visible = true
	await get_tree().create_timer(10.0).timeout
	reduced_damage_alert_label.visible = false
