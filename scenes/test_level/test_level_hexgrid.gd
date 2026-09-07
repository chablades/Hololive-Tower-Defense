extends Node3D

@onready var hexagon_2d_to_3d: HexagonTileMapLayer = $Hexagon2DTo3D
@onready var hex_to_3d_sync: Node = $Hexagon2DTo3D/HexTo3DSync
@onready var start: Marker2D = $Hexagon2DTo3D/Start
@onready var end: Marker2D = $Hexagon2DTo3D/End
@onready var soldier_enemy: Enemy = $SoldierEnemy


var _path_local: Array[Vector2] = []
var _path_world: Array[Vector3] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hexagon_2d_to_3d.hide()
	soldier_enemy.global_position = hex_to_3d_sync.pixel_position_to_world(start.position)
	var map_start: Vector2i = hexagon_2d_to_3d.local_to_map(start.position)
	var map_end: Vector2i = hexagon_2d_to_3d.local_to_map(end.position)
	print("Start: %s | End: %s" % [map_start, map_end])
	_path_local = generate_a_star_path(map_start, map_end)
	print(_path_local)
	for coordinate in _path_local:
		_path_world.append(hex_to_3d_sync.pixel_position_to_world(coordinate))
	print(_path_world)
	soldier_enemy.go_to(_path_world)


func generate_a_star_path(map_start: Vector2i, map_end: Vector2i) -> Array[Vector2]:
	var start_id: int = hexagon_2d_to_3d.pathfinding_get_point_id(map_start)
	var end_id: int = hexagon_2d_to_3d.pathfinding_get_point_id(map_end)
	var path_ids: PackedInt64Array = hexagon_2d_to_3d.astar.get_id_path(start_id, end_id)
	var path_local: Array[Vector2] = []
	for id in path_ids:
		path_local.append(hexagon_2d_to_3d.astar.get_point_position(id))
	return path_local
