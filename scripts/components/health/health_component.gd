class_name HealthComponent

extends Node

signal died

@export var max_health: float = 100

var _current_health: float = 0;


func _ready() -> void:
	_current_health = max_health


func get_max_health() -> float:
	return max_health


func get_current_health() -> float:
	return _current_health


func take_damage(damage: float) -> void:
	if _current_health <= 0:
		return
	else:
		if (_current_health - damage) <= 0:
			_current_health = 0
			died.emit()
		else:
			_current_health -= damage


func heal(heal_amount: float) -> void:
	if (_current_health + heal_amount) >= max_health:
		_current_health = max_health
	else:
		_current_health += heal_amount
