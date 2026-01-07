extends Node

signal game_over()
signal pause_game()
signal game_timescale_changed(new_timescale: String)
signal wave_25_passed()
signal starting_new_game()


# Dealing with enemies
signal enemy_died()
signal enemy_reached_end(lives_taken_if_reach_finish: int)
signal enemy_clicked_on(enemy: CharacterBody2D)


# Dealing with inputs
signal spacebar_pressed()
signal tower_clicked_on(tower: Node2D)
signal displaying_tower_stats()
signal displaying_tower_placement_cost()
signal tower_deleted(tower: Node2D)
signal change_menu_screen_button_pressed(chosen_screen: GameTypes.MenuScreen)


# Dealing with resources
signal money_changed(new_money: int)
signal lives_changed(new_lives: int)
signal wave_changed(new_wave: int)
signal not_enough_money()
