extends Resource
class_name WaveInfo

const ENEMY_WEAKLING_SCENE = preload("res://game/entities/enemies/weakling.tscn")
const ENEMY_FAST_WEAKLING_SCENE = preload("res://game/entities/enemies/fast_weakling.tscn")
const ENEMY_BUBBA_SCENE = preload("res://game/entities/enemies/bubba.tscn")
const ENEMY_ULTRA_TANK_SCENE = preload("res://game/entities/enemies/ultra_tank.tscn")
const ENEMY_BOSSMAN_SCENE = preload("res://game/entities/enemies/bossman.tscn")
const ENEMY_SKELETOR_SCENE = preload("res://game/entities/enemies/skeletor.tscn")
const ENEMY_GOBLIN_SCENE = preload("res://game/entities/enemies/goblin.tscn")
const ENEMY_ARMORED_GRUNT_SCENE = preload("res://game/entities/enemies/armored_grunt.tscn")
const ENEMY_WATERY_SCENE = preload("res://game/entities/enemies/watery.tscn")
const ENEMY_GLUG_SCENE = preload("res://game/entities/enemies/glug.tscn")


## Key is wave number and array holds enemy type, amount of that enemy spawned, interval between
## spawns, and time until next group spawns. Array can have multiple enemies
# Make waves static so it can be globally accessed like const without needing to instance object with .new
static var waves: Dictionary[int, Array] = {
	1: [GameTypes.EnemyType.Weakling, 10, 2.5],
	2: [GameTypes.EnemyType.Weakling, 12, 2.0],
	3: [GameTypes.EnemyType.Weakling, 5, 0.2, 2.0, GameTypes.EnemyType.Weakling, 1, 3, 2.0,
			GameTypes.EnemyType.Weakling, 6, 0.2],
	4: [GameTypes.EnemyType.Weakling, 16, 1.0],
	5: [GameTypes.EnemyType.Weakling, 12, 0.3],
	6: [GameTypes.EnemyType.Weakling, 12, 0.5],
	7: [GameTypes.EnemyType.Weakling, 12, 0.1],
	8: [GameTypes.EnemyType.FastWeakling, 4, 2.0],
	9: [GameTypes.EnemyType.Bubba, 1, 5.0],
	10: [GameTypes.EnemyType.Bubba, 3, 5.0],
	11: [GameTypes.EnemyType.Weakling, 12, 0.1, 2.0, GameTypes.EnemyType.Bubba, 2, 5.0, 3.0,
			GameTypes.EnemyType.Weakling, 12, 0.1, 3.0, GameTypes.EnemyType.Bubba, 2, 5.0],
	12: [GameTypes.EnemyType.Weakling, 80, 0.1],
	13: [GameTypes.EnemyType.FastWeakling, 10, 0.02],
	14: [GameTypes.EnemyType.FastWeakling, 20, 0.02],
	15: [GameTypes.EnemyType.Bubba, 4, 3.0, 5.0, GameTypes.EnemyType.UltraTank, 1, 1.0],
	16: [GameTypes.EnemyType.Skeletor, 12, 0.5],
	17: [GameTypes.EnemyType.Skeletor, 12, 0.02],
	18: [GameTypes.EnemyType.Skeletor, 24, 0.02],
	19: [GameTypes.EnemyType.Goblin, 8, 0.8, 3.0, GameTypes.EnemyType.Bubba, 3, 3.0, 3.0,
			GameTypes.EnemyType.Skeletor, 12, 0.5, 2.0, GameTypes.EnemyType.Goblin, 6, 1.0],
	20: [GameTypes.EnemyType.Skeletor, 10, .7, 3.0, GameTypes.EnemyType.Watery, 1, 1., 5.,
			GameTypes.EnemyType.Skeletor, 10, .7],
	21: [GameTypes.EnemyType.Watery, 5, 5.],
	22: [GameTypes.EnemyType.ArmoredGrunt, 5, 5., 2., GameTypes.EnemyType.ArmoredGrunt, 30, 0.2],
	23: [GameTypes.EnemyType.Skeletor, 8, 0.5, 1.5, GameTypes.EnemyType.Bubba, 8, 0.5, 1.5,
			GameTypes.EnemyType.Goblin, 16, 0.4, 3., GameTypes.EnemyType.Watery, 2, 5., 5.,
			GameTypes.EnemyType.Bubba, 20, 0.5, 3., GameTypes.EnemyType.UltraTank, 1, 0.5],
	24: [GameTypes.EnemyType.UltraTank, 4, 3.5, 3., GameTypes.EnemyType.Bubba, 10, 0.7, 1.,
			GameTypes.EnemyType.ArmoredGrunt, 20, 0.7, 3., GameTypes.EnemyType.FastWeakling, 8, .5],
	25: [GameTypes.EnemyType.Glug, 1, 1.],
	26: [GameTypes.EnemyType.FastWeakling, 20, 0.2, 3., GameTypes.EnemyType.FastWeakling, 10, 0.7],
	27: [GameTypes.EnemyType.Watery, 4, 3, 3., GameTypes.EnemyType.Bubba, 10, 0.7, 1.,
		GameTypes.EnemyType.Skeletor, 10, .5, 2., GameTypes.EnemyType.FastWeakling, 10, 0.7],
	28: [GameTypes.EnemyType.Glug, 1, 1., 5., GameTypes.EnemyType.ArmoredGrunt, 5, 3., 2.,
		GameTypes.EnemyType.Goblin, 14, 0.4],
	29: [GameTypes.EnemyType.Weakling, 10, .2, 1., GameTypes.EnemyType.FastWeakling, 15, 0.2, 3.,
		GameTypes.EnemyType.Bubba, 20, 0.3, 3., GameTypes.EnemyType.UltraTank, 3, 1.],
	30: [GameTypes.EnemyType.BossMan, 1, 1.0],
}


static var starting_money_at_given_wave: Dictionary[int, int] = {
	2: 600,
	3: 980,
	4: 1395,
	5: 1875,
	6: 2334,
	7: 2809,
	8: 3298,
	9: 3758,
	10: 4348,
	11: 5348,
	12: 6796,
	13: 8011,
	14: 11013,
	15: 11842,
	16: 13477,
	17: 14517,
	18: 15563,
	19: 17214,
	20: 1721400,
	21: 1721400,
	22: 1721400,
	23: 1721400,
	24: 1721400,
	25: 1721400,
	26: 1721400,
	27: 1721400,
	28: 1721400,
	29: 1721400,
	30: 1721400,
}
