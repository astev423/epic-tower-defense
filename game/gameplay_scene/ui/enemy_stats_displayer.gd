extends Node2D

@onready var stats_label: Label = $StatsLabel

func _ready() -> void:
	EventBus.enemy_clicked_on.connect(_on_enemy_clicked_on)
	EventBus.displaying_tower_stats.connect(hide_enemy_stats)
	EventBus.displaying_tower_placement_cost.connect(hide_enemy_stats)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		hide_enemy_stats()


func _on_enemy_clicked_on(enemy: CharacterBody2D) -> void:
	display_stats_for_enemy(enemy)


func display_stats_for_enemy(enemy: CharacterBody2D) -> void:
	self.show()
	# Make these arrays so we can pass them by reference
	var weaknesses := [""]
	var strengths := [""]
	get_strengths_and_weaknesses(enemy, weaknesses, strengths)
	if weaknesses[0].length() > 85 or strengths[0].length() > 85:
		print_debug("too many weaknesses/strengths to display on card")
		get_tree().quit()

	stats_label.text = "Name: %s   Health: %d   Movement speed: %d   kill award: %d
			Weaknesses: %s
			Strengths: %s" % [
				enemy.stats.name,
				enemy.stats.health,
				enemy.stats.movement_speed,
				enemy.stats.money_awarded_if_killed,
				weaknesses[0],
				strengths[0]
			]


func get_strengths_and_weaknesses(enemy: CharacterBody2D, weaknesses: Array, strengths: Array) -> void:
	for type: GameTypes.EnemyType in enemy.stats.damage_modifiers.keys():
		var modifier: float = enemy.stats.damage_modifiers[type]

		if modifier > 1:
			add_info_to_str(type, weaknesses, modifier)
		else:
			add_info_to_str(type, strengths, modifier)


func add_info_to_str(type: GameTypes.EnemyType, str_array: Array, modifier: float) -> void:
	if type == GameTypes.AttackType.Blunt:
		str_array[0] += "cannon: %.2fX, " % modifier
	elif type == GameTypes.AttackType.Energy:
		str_array[0] += "crystal: %.2fX, " % modifier
	elif type == GameTypes.AttackType.Explosive:
		str_array[0] += "rockets: %.2fX, " % modifier
	elif type == GameTypes.AttackType.Fire:
		str_array[0] += "fire: %.2fX, " % modifier
	elif type == GameTypes.AttackType.Piercing:
		str_array[0] += "machine gun: %.1fX, crossbow: %.2fX, " % [modifier, modifier]
	else:
		print_debug("fatal error, type doesn't exist")
		get_tree().quit()


func hide_enemy_stats() -> void:
	self.hide()
