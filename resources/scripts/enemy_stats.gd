extends Resource
class_name EnemyStats

@export var damage_modifiers: Dictionary[GameTypes.AttackType, float]
@export var movement_speed: float
@export var lives_taken_if_reach_finish: int
@export var money_awarded_if_killed: int
@export var health: float
@export var health_bar_offset: Vector2
@export var type: GameTypes.EnemyType
