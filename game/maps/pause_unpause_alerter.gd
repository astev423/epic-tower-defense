extends Node
class_name PauseUnpause

@onready var plains_enemy_spawner = $"../Plains/PlainsEnemySpawner"
var parent: Node2D

signal pause_event()

## Always let this run no matter what
func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	plains_enemy_spawner.connect("wave_over", pause_event.emit)


## Little bit of coupling
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spacebar"):
		pause_event.emit()
