class_name PathFollowingComponent

extends MovementComponent


@export var velocity: VelocityComponent
var _path: Array[Vector3] = []
var _current_index: int = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if _path:
		if _parent.global_position.distance_to(_path[_current_index]) > 0.1:
			follow_path(delta)
		else:
			if _current_index == _path.size() - 1:
				_parent.on_destination_reached()
				_current_index = 0
				_path = []
			else:
				_current_index += 1
				moving_right.emit(is_moving_right())


func is_moving_right() -> bool:
	if (_parent.global_position.x - _path[_current_index].x) > 0:
		return true
	else: return false


func go_to(path: Variant) -> void:
	if path:
		_path = path as Array[Vector3]
		_current_index = 0
		moving_right.emit(is_moving_right())


func follow_path(delta: float) -> void:
	var target_position: Vector3 = _path[_current_index]
	var new_position = _parent.global_position.move_toward(target_position, velocity.get_max_speed() * delta)
	_parent.global_position = new_position
	
