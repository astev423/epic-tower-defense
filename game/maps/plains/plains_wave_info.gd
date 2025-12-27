extends Resource
class_name PlainsWaveInfo

const ENEMY_WEAKLING_SCENE = preload("res://game/enemies/weakling/weakling.tscn")

## first element holds the time between waves, second holds the enemies for that wave
var waves: Array[Array] = [
	[
		2.0,
		[
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
		]
	],
	[
		1.5,
		[
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
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
		]
	],
	[
		0.5,
		[
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
		]
	],
	[
		0.3,
		[
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
		]
	],
	[
		0.7,
		[
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
		]
	],
	[
		0.1,
		[
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
			EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling, EnemyTypes.Type.Weakling,
		]
	],
]
