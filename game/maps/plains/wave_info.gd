extends Resource
class_name WaveInfo

const ENEMY_WEAKLING_SCENE = preload("res://game/enemies/weakling/weakling.tscn")

## first element holds the time between waves, second holds the enemies for that wave
var waves: Array[Array] = [
	[
		2.0,
		[
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
		]
	],
	[
		1.0,
		[
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
		]
	],
]
