extends Node

var cur_lives: int
var cur_money: int
var cur_wave: int


## Tries to buy tower, if not then return false, if it does buy then decrease money and display it
func is_tower_affordable(cost) -> bool:
	if GameState.cur_money < cost:
		EventBus.not_enough_money.emit()
		return false

	GameState.cur_money -= cost
	EventBus.money_changed.emit(GameState.cur_money)
	return true


func add_money(amount: int) -> void:
	GameState.cur_money += amount
	EventBus.money_changed.emit(GameState.cur_money)


func decrease_lives(lives_taken_if_reach_finish) -> void:
	GameState.cur_lives -= lives_taken_if_reach_finish
	EventBus.lives_changed.emit(GameState.cur_lives)

	# TODO Show game over screen if lives run out
	if GameState.cur_lives <= 0:
		assert(GameState.cur_lives > 0)


func handle_wave_over(completed_wave_number) -> void:
	add_money((100 * log(10 * completed_wave_number)) / log(10) as int)
	increase_wave_count()


func increase_wave_count() -> void:
	GameState.cur_wave += 1
	EventBus.wave_changed.emit(GameState.cur_wave)
