extends Resource
class_name GameTypes

enum MenuScreen {
	HOME,
	LEVEL_SELECTION,
	GAME_OVER,
	VICTORY_SCREEN,
}

enum LevelType {
	Dunes,
	Plains,
	Dungeon
}

enum TowerType {
	CANNON1,
	CANNON2,
	CANNON3,
	ROCKET_LAUNCHER1,
	ROCKET_LAUNCHER2,
	ROCKET_LAUNCHER3,
	CROSSBOW1,
	CROSSBOW2,
	CROSSBOW3,
	CRYSTAL1,
	CRYSTAL2,
	CRYSTAL3,
	MACHINE_GUN1,
	MACHINE_GUN2,
	MACHINE_GUN3,
	FLAMETHROWER1,
	FLAMETHROWER2,
	FLAMETHROWER3,
	NONE,
}

enum EnemyType {
	Weakling,
	FastWeakling,
	Bubba,
	UltraTank,
	Skeletor,
	Goblin,
	ArmoredGrunt,
	Watery,
	Glug,
	BossMan,
}

enum AttackType {
	Piercing,
	Blunt,
	Fire,
	Explosive,
	Energy,
}
