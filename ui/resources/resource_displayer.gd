extends Node2D

"""
This connects gamestate global to signals
"""

@onready var money_label: Label = $MoneyLabel
@onready var lives_label: Label = $LivesLabel
@onready var waves_label: Label = $WavesLabel
var enemy_spawner: Node



# Enemy spawner comes from maps
func _ready() -> void:
	EventBus.connect("money_changed", update_money_label)
	EventBus.connect("wave_changed", update_waves_label)
	EventBus.connect("lives_changed", update_lives_label)
	# Allow money stuff while paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	setup_label_values()


func update_money_label(new_money_amount: int) -> void:
	money_label.text = "Money: %d" % new_money_amount


func update_lives_label(new_lives_amount: int) -> void:
	lives_label.text = "Lives: %d" % new_lives_amount


func update_waves_label(new_wave_num: int) -> void:
	lives_label.text = "Lives: %d" % new_wave_num


func setup_label_values()-> void:
	money_label.text = "Money: %d" % GameState.get_cur_money()
	lives_label.text = "Lives: %d" % GameState.get_cur_lives()
	waves_label.text = "Wave: %d/50" % GameState.get_cur_wave()
