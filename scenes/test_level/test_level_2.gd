extends Node3D


@onready var grid_map: GridMap = $GridMap
@onready var start: Marker3D = $GridMap/Start
@onready var end: Marker3D = $GridMap/End
@onready var soldier_enemy: Enemy = $SoldierEnemy



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var grid_data: GridData = GridData.new(grid_map)
	var path_finder: GridPathFinder = GridPathFinder.new(grid_data)
	var start_grid: Vector3i = grid_data.world_to_grid(start.position)
	var end_grid: Vector3i = grid_data.world_to_grid(end.position)
	var path_3d: Array[Vector3] = path_finder.get_world_path(start_grid, end_grid)
	soldier_enemy.go_to(path_3d)
