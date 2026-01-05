extends Node

signal enemy_died()
signal enemy_reached_end(lives_taken_if_reach_finish: int)
signal tower_clicked_on(tower: Node2D)
signal not_enough_money()
signal money_changed(new_money: int)
signal lives_changed(new_lives: int)
signal wave_changed(new_wave: int)
signal game_over()
signal pause_game()
signal game_timescale_changed(new_timescale: String)
signal spacebar_pressed()
signal wave_25_passed()
