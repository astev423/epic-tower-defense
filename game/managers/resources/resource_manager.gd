extends Node2D

"""
This class receives money every time an enemy dies since each enemy death calls add_money
because we are in money manager group, maybe find way to prevent upward communication to make reading
code easier
"""

@onready var money_label: Label = $MoneyLabel
@onready var lives_label: Label = $LivesLabel
@onready var waves_label: Label = $WavesLabel
var enemy_spawner: Node
var cur_lives = 200
var cur_money = 3000
var cur_wave = 1

signal no_money()


func _ready() -> void:
	enemy_spawner.connect("enemy_spawned", connect_to_spawned_enemy)
	enemy_spawner.connect("wave_over", handle_wave_over)
	add_to_group("resource_manager")
	money_label.text = "Money: %d" % cur_money
	# Allow money stuff while paused
	process_mode = Node.PROCESS_MODE_ALWAYS


## Tries to buy tower, if not then return false, if it does buy then decrease money and display it
func is_tower_affordable(cost) -> bool:
	if cur_money < cost:
		no_money.emit()
		return false

	cur_money -= cost
	money_label.text = "Money: %d" % cur_money
	return true


func add_money(amount: int) -> void:
	cur_money += amount
	money_label.text = "Money: %d" % cur_money


func decrease_lives(lives_taken_if_reach_finish) -> void:
	cur_lives -= lives_taken_if_reach_finish
	lives_label.text = "Lives: %d" % cur_lives

	# TODO Show game over screen if lives run out
	if cur_lives <= 0:
		assert(cur_lives > 0)

func connect_to_spawned_enemy(enemy) -> void:
	enemy.connect("enemy_reached_end", decrease_lives)


func handle_wave_over() -> void:
	add_money((100 * log(10 * cur_money)) / log(10))
	increase_wave_count()


func increase_wave_count() -> void:
	cur_wave += 1
	waves_label.text = "Wave: %d/50" % cur_wave
