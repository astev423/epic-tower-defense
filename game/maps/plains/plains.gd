extends Node2D

const TILE_SIZE = 64
const NUM_HORIZONTAL_TILES = 26
const NUM_VERTICAL_TILES = 16

@onready var money_manager = $"../MapUI/MoneyManager"
@onready var no_money_label = $NoMoneyWarning

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	no_money_label.z_index = 100
	money_manager.connect("no_money", display_no_money_warning)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func display_no_money_warning() -> void:
	no_money_label.visible = true
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = 1.3
	timer.connect("timeout", hide_no_money_warning)
	timer.start()


func hide_no_money_warning() -> void:
	no_money_label.visible = false
