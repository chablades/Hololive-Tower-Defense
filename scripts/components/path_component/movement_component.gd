class_name MovementComponent

extends Node

signal moving_right(right: bool)

var _parent: Enemy


func _ready() -> void:
	_parent = get_parent() as Enemy
	if _parent == null:
		push_error("No parent node for MovementComponent")


func go_to(data: Variant) -> void:
	push_error("go_to() not implemented")
