extends Resource
class_name PlainsWaveInfo

const ENEMY_WEAKLING_SCENE = preload("res://game/enemies/weakling/weakling.tscn")
const ENEMY_FAST_WEAKLING_SCENE = preload("res://game/enemies/weakling/fast_weakling.tscn")
const ENEMY_BUBBA_SCENE = preload("res://game/enemies/bubba/bubba.tscn")


## Key is wave number and array holds enemy type, amount of that enemy spawned, and interval between
## spawns. Array can have multiple enemies
var waves: Dictionary[int, Array] = {
	1: [EnemyTypes.Type.Weakling, 6, 2.0],
	2: [EnemyTypes.Type.Weakling, 6, 1.5],
	3: [EnemyTypes.Type.Weakling, 12, 1.0],
	4: [EnemyTypes.Type.Weakling, 9, 0.5],
	5: [EnemyTypes.Type.Weakling, 12, 0.3],
	6: [EnemyTypes.Type.Weakling, 12, 0.7],
	7: [EnemyTypes.Type.Weakling, 12, 0.1],
	8: [EnemyTypes.Type.FastWeakling, 4, 2.0],
	9: [EnemyTypes.Type.Bubba, 1, 5.0],
	10: [EnemyTypes.Type.Bubba, 3, 5.0],
	11: [EnemyTypes.Type.Weakling, 12, 0.1, EnemyTypes.Type.Bubba, 2, 5.0,
		EnemyTypes.Type.Weakling, 12, 0.1],
}
