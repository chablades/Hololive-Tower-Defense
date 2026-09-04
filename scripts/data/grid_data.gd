class_name GridData

extends RefCounted


const TERRAIN_TYPE: Dictionary = {
	"path": GameEnums.TerrainTraits.WALKABLE | GameEnums.TerrainTraits.DEPLOYABLE_MELEE,
	"grass_tall": GameEnums.TerrainTraits.DEPLOYABLE_RANGE,
}


var _map_cache: Dictionary[Vector3i, int] = {} # Holds details about the cell at a coordinate
var _occupied_cells: Dictionary[Vector3i, bool] = {}
var _grid_map: GridMap
var _min_coordinates: Vector3i = Vector3i(999, 999, 999)
var _max_coordinates: Vector3i = Vector3i(-999, -999, -999)


func _init(grid_map: GridMap) -> void:
	_grid_map = grid_map
	build_map_cache()


func get_max_coordinates() -> Vector3i:
	return _max_coordinates


func get_min_coordinates() -> Vector3i:
	return _min_coordinates


func get_2d_cell_size() -> Vector2i:
	return Vector2i(_grid_map.cell_size.x, _grid_map.cell_size.z)


func get_not_walkable_cells() -> Array[Vector3i]:
	var non_walkable: Array[Vector3i] = []
	for coordinate in _map_cache:
		if not has_trait(coordinate, GameEnums.TerrainTraits.WALKABLE):
			non_walkable.append(coordinate)
	return non_walkable
			
	


func build_map_cache() -> void:
	var used_cells: Array[Vector3i] = _grid_map.get_used_cells()
	for coordinates in used_cells:
		var terrain_traits: int = get_terrain_traits(coordinates)
		_occupied_cells[coordinates] = false
		_map_cache[coordinates] = terrain_traits
		_min_coordinates = _min_coordinates.min(coordinates)
		_max_coordinates = _max_coordinates.max(coordinates)


# Returns a cells traits
func get_terrain_traits(grid_coordinates: Vector3i) -> int:
	var mesh_id: int = _grid_map.get_cell_item(grid_coordinates)
	var block_name: String = _grid_map.mesh_library.get_item_name(mesh_id)
	var block_traits: int = TERRAIN_TYPE.get(block_name, 0)
	return block_traits


# Checks if cell has a certain trait
func has_trait(coordinates: Vector3i, trait_flag: GameEnums.TerrainTraits) -> bool:
	if _map_cache.has(coordinates):
		return (_map_cache[coordinates] & trait_flag) != 0
	else:
		return false


# Check if cell is not out-of-bounds
func is_valid_cell(coordinates: Vector3i) -> bool:
	if _map_cache.has(coordinates):
		return true
	else:
		return false


# Update occupied status of cell
func set_cell_occupied(coordinates: Vector3i, is_occupied: bool) -> void:
	if _occupied_cells.has(coordinates):
		_occupied_cells[coordinates] = is_occupied
	else:
		print("Error: Cell %s does not exist in occupied_cells cache!" % coordinates)


func world_to_grid(position: Vector3) -> Vector3i:
	return _grid_map.local_to_map(position)


func grid_to_world(coordinates: Vector3i) -> Vector3:
	if not is_valid_cell(coordinates):
		push_error("grid_to_world: Coordinates is out of bounds")
		return Vector3.ZERO
	var mesh_id: int = _grid_map.get_cell_item(coordinates)
	var mesh: Mesh = _grid_map.mesh_library.get_item_mesh(mesh_id)
	var bounding_box: AABB = mesh.get_aabb()
	var mesh_height: float = bounding_box.position.y + bounding_box.size.y
	var local_coordinates: Vector3 = _grid_map.map_to_local(coordinates)
	return Vector3(local_coordinates.x,  mesh_height, local_coordinates.z)
	
