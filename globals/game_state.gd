extends Node

var _cur_money: int
var _cur_lives: int
var _cur_wave: int


## Tries to buy tower, if not then return false, if it does buy then decrease money and display it
func is_tower_affordable(cost) -> bool:
	if GameState._cur_money < cost:
		EventBus.not_enough_money.emit()
		return false

	GameState._cur_money -= cost
	EventBus.money_changed.emit(GameState._cur_money)
	return true


func add_money(amount: int) -> void:
	GameState._cur_money += amount
	EventBus.money_changed.emit(GameState._cur_money)


func decrease_lives(lives_taken_if_reach_finish) -> void:
	GameState._cur_lives -= lives_taken_if_reach_finish
	EventBus.lives_changed.emit(GameState._cur_lives)

	# TODO Show game over screen if lives run out
	if GameState._cur_lives <= 0:
		assert(GameState._cur_lives > 0)


func handle_wave_over(completed_wave_number) -> void:
	add_money((100 * log(10 * completed_wave_number)) / log(10) as int)
	increase_wave_count()


func increase_wave_count() -> void:
	GameState._cur_wave += 1
	EventBus.wave_changed.emit(GameState._cur_wave)


# Getters and setters so we keep encapsulation, don't want to accidently modify these without the API
func get_cur_money() -> int:
	return _cur_money
func get_cur_lives() -> int:
	return _cur_lives
func get_cur_wave() -> int:
	return _cur_wave


func set_variables(lives: int, money: int, wave: int) -> void:
	_cur_lives = lives
	_cur_money = money
	_cur_wave = wave
