extends Node2D

"""
This connects gamestate global to signals
"""

@onready var money_label: Label = $MoneyLabel
@onready var lives_label: Label = $LivesLabel
@onready var waves_label: Label = $WavesLabel
var enemy_spawner: Node


func _ready() -> void:
	EventBus.money_changed.connect(update_money_label)
	EventBus.wave_changed.connect(update_waves_label)
	EventBus.lives_changed.connect(update_lives_label)
	setup_label_values()


func update_money_label(new_money_amount: int) -> void:
	money_label.text = "Money: %d" % new_money_amount


func update_lives_label(new_lives_amount: int) -> void:
	lives_label.text = "Lives: %d" % new_lives_amount


func update_waves_label(new_wave_num: int) -> void:
	waves_label.text = "Waves: %d/40" % new_wave_num


func setup_label_values()-> void:
	update_money_label(GameState.get_cur_money_amount())
	update_lives_label(GameState.get_cur_lives_num())
	update_waves_label(GameState.get_cur_wave_num())
