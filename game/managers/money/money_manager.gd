extends Node2D

@onready var money_label: Label = $MoneyLabel
@onready var cur_money = 300

signal no_money()

func _ready() -> void:
	add_to_group("money_manager")
	money_label.text = "Money: %d" % cur_money
	# Allow money stuff while paused
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


## Tries to buy tower, if not then return false, if it does buy then decrease money and display it
func attempt_buy_tower(cost) -> bool:
	if cur_money < cost:
		no_money.emit()
		return false

	cur_money -= 100
	money_label.text = "Money: %d" % cur_money
	return true


func add_money(amount: int) -> void:
	cur_money += amount
	money_label.text = "Money: %d" % cur_money
