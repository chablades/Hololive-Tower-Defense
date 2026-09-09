extends Node

@export var camera: Camera3D

signal hovered_tile_changed(coord: Vector2i, valid: bool)

var _current_hovered_coordinate: Vector2i = Vector2i.ZERO
var _has_hover: bool = false

func _process(_delta: float) -> void:
	var mouse_2d_pos = get_viewport().get_mouse_position()
	var ray_origin: Vector3 = camera.project_ray_origin(mouse_2d_pos)
	var ray_direction = camera.project_ray_normal(mouse_2d_pos)
	var ray_end: Vector3 = ray_origin + (ray_direction * 1000)
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	var result = camera.get_world_3d().direct_space_state.intersect_ray(query)
	
	if result:
		var grid_coord_meta_data = result["collider"].get_meta("grid_coord")
		if _current_hovered_coordinate != grid_coord_meta_data:
			_current_hovered_coordinate = grid_coord_meta_data
			_has_hover = true
			hovered_tile_changed.emit(_current_hovered_coordinate, _has_hover)
			print(_current_hovered_coordinate)
	else: 
		if _has_hover:
			_current_hovered_coordinate = Vector2i.ZERO
			_has_hover = false
			hovered_tile_changed.emit(_current_hovered_coordinate, _has_hover)
