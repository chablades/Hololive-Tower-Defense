class_name GameEnums

# Terrain traits that affect what can be done
enum TerrainTraits {
	WALKABLE = 1 << 0,
	DEPLOYABLE_RANGE = 1 << 1,
	DEPLOYABLE_MELEE = 1 << 2,
}
