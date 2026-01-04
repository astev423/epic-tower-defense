extends Resource
class_name WaveInfo

const ENEMY_WEAKLING_SCENE = preload("res://game/entities/enemies/weakling.tscn")
const ENEMY_FAST_WEAKLING_SCENE = preload("res://game/entities/enemies/fast_weakling.tscn")
const ENEMY_BUBBA_SCENE = preload("res://game/entities/enemies/bubba.tscn")
const ENEMY_ULTRA_TANK_SCENE = preload("res://game/entities/enemies/ultra_tank.tscn")
const ENEMY_BOSSMAN_SCENE = preload("res://game/entities/enemies/bossman.tscn")
const ENEMY_SKELETOR_SCENE = preload("res://game/entities/enemies/skeletor.tscn")
const ENEMY_GOBLIN_SCENE = preload("res://game/entities/enemies/goblin.tscn")


## Key is wave number and array holds enemy type, amount of that enemy spawned, and interval between
## spawns. Array can have multiple enemies
# Make waves static so it can be globally accessed like const without needing to instance object with .new
static var waves: Dictionary[int, Array] = {
	1: [GameTypes.EnemyType.Weakling, 6, 2.0],
	2: [GameTypes.EnemyType.Weakling, 6, 1.5],
	3: [GameTypes.EnemyType.Weakling, 12, 1.0],
	4: [GameTypes.EnemyType.Weakling, 9, 0.5],
	5: [GameTypes.EnemyType.Weakling, 12, 0.3],
	6: [GameTypes.EnemyType.Weakling, 12, 0.7],
	7: [GameTypes.EnemyType.Weakling, 12, 0.1],
	8: [GameTypes.EnemyType.FastWeakling, 4, 2.0],
	9: [GameTypes.EnemyType.Bubba, 1, 5.0],
	10: [GameTypes.EnemyType.Bubba, 3, 5.0],
	11: [GameTypes.EnemyType.Weakling, 12, 0.1, GameTypes.EnemyType.Bubba, 2, 5.0,
		GameTypes.EnemyType.Weakling, 12, 0.1],
	12: [GameTypes.EnemyType.Weakling, 80, 0.1],
	13: [GameTypes.EnemyType.FastWeakling, 20, 0.02],
	14: [GameTypes.EnemyType.FastWeakling, 80, 0.02],
	15: [GameTypes.EnemyType.UltraTank, 1, 1.0],
	16: [GameTypes.EnemyType.BossMan, 1, 1.0],
	17: [GameTypes.EnemyType.Goblin, 1, 1.0, GameTypes.EnemyType.Skeletor, 1, 1.0],
}
