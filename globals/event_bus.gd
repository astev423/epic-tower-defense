extends Node

signal enemy_died()
signal enemy_reached_end(lives_taken_if_reach_finish: int)
signal wave_over(completed_wave_number: int)
signal tower_clicked_on(tower)
signal not_enough_money()
signal money_changed(new_money: int)
signal lives_changed(new_lives: int)
signal wave_changed(new_wave: int)
signal game_over()
signal pause_event()
