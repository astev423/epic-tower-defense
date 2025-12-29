extends Resource
class_name PlainsWaveInfo

const ENEMY_WEAKLING_SCENE = preload("res://game/enemies/weakling/weakling.tscn")


## Key is wave number and array holds enemy type, amount of that enemy spawned, and interval between
## spawns. Array can have multiple enemies
var waves: Dictionary[int, Array] = {
	1: [EnemyTypes.Type.Weakling, 6, 2.0],
	2: [EnemyTypes.Type.Weakling, 6, 1.5],
	3: [EnemyTypes.Type.Weakling, 12, 1.0],
	4: [EnemyTypes.Type.Weakling, 9, 0.5],
	5: [EnemyTypes.Type.Weakling, 12, 0.3],
	6: [EnemyTypes.Type.Weakling, 12, 0.7],
	7: [EnemyTypes.Type.Weakling, 2, 0.1],
}
