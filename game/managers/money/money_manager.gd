extends Node2D

"""
This class receives money every time an enemy dies since each enemy death calls add_money
because we are in money manager group, maybe find way to prevent upward communication to make reading
code easier
"""

@onready var money_label: Label = $MoneyLabel
@onready var cur_money = 300

signal no_money()


func _ready() -> void:
	add_to_group("money_manager")
	money_label.text = "Money: %d" % cur_money
	# Allow money stuff while paused
	process_mode = Node.PROCESS_MODE_ALWAYS


## Tries to buy tower, if not then return false, if it does buy then decrease money and display it
func is_tower_affordable(cost) -> bool:
	if cur_money < cost:
		no_money.emit()
		return false

	cur_money -= 100
	money_label.text = "Money: %d" % cur_money
	return true


func add_money(amount: int) -> void:
	cur_money += amount
	money_label.text = "Money: %d" % cur_money
