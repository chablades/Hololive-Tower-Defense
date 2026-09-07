@tool

extends HexagonTileMapLayer


func _pathfinding_get_tile_weight(coords: Vector2i) -> float:
	return 1.0


func _pathfinding_does_tile_connect(tile: Vector2i, neighbor: Vector2i) -> bool:
	var tile_data: TileData = get_cell_tile_data(tile)
	var neighbor_data: TileData = get_cell_tile_data(neighbor)
	if tile_data == null:
		push_error("_pathfinding_does_tile_connect: Tile does not exist.")
		return false
	if neighbor_data == null:
		push_error("_pathfinding_does_tile_connect: Neighbor does not exist.")
		return false
	var tile_walkable: bool = tile_data.get_custom_data("is_walkable")
	var neighbor_walkable: bool = neighbor_data.get_custom_data("is_walkable")
	if tile_walkable and neighbor_walkable:
		return true
	else: 
		return false
