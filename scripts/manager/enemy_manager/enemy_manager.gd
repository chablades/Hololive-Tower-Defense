extends Node

const ENEMY = preload("uid://cgvjr8wvm1b61")


func register_enemy() -> void:
	pass
	
	
func remove_enemy(enemy: Enemy) -> void:
	print("Removing: %s" % enemy.name)
	enemy.queue_free()
