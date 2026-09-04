class_name GridPathFinder

extends RefCounted

var _astar_grid: AStarGrid2D
var _grid_data: GridData


func _init(grid_data: GridData) -> void:
	_grid_data = grid_data
	build_astar_grid()


# Initialize shortest path grid layout
func build_astar_grid() -> void:
	_astar_grid = AStarGrid2D.new()
	var region_width: int = _grid_data.get_max_coordinates().x - _grid_data.get_min_coordinates().x + 1
	var region_height: int = _grid_data.get_max_coordinates().z - _grid_data.get_min_coordinates().z + 1
	var region: Rect2i = Rect2i(_grid_data.get_min_coordinates().x, _grid_data.get_min_coordinates().z, region_width, region_height)
	_astar_grid.region = region
	_astar_grid.cell_size = _grid_data.get_2d_cell_size()
	_astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	_astar_grid.update()
	for coordinate in _grid_data.get_not_walkable_cells():
		set_path_solid(Vector2i(coordinate.x, coordinate.z))


func set_path_solid(coordinate: Vector2i) -> void:
	_astar_grid.set_point_solid(coordinate)


func get_path(start: Vector3i, end: Vector3i) -> Array[Vector2i]:
	var start_2d = Vector2i(start.x, start.z)
	var end_2d = Vector2i(end.x, end.z)
	var path = _astar_grid.get_id_path(start_2d, end_2d)
	return path

func get_world_path(start: Vector3i, end: Vector3i) -> Array[Vector3]:
	var path_3d: Array[Vector3] = []
	var updated_path: Array[Vector2i] = get_path(start, end)
	path_3d = Array(updated_path.map(func(path): return _grid_data.grid_to_world(Vector3i(path.x, 0 , path.y))), TYPE_VECTOR3, "", null)
	return path_3d
