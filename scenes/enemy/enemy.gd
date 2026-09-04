class_name Enemy

extends CharacterBody3D

signal reached_end(enemy: Enemy)
signal died(enemy: Enemy)

@onready var health_component: HealthComponent = $HealthComponent
@onready var movement_component: MovementComponent = $MovementComponent
@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D


func _ready() -> void:
	health_component.died.connect(emit_died)
	movement_component.moving_right.connect(on_moving_right)
	animated_sprite_3d.play("Walk")
	

func emit_died() -> void:
	died.emit(self)


func on_destination_reached() -> void:
	reached_end.emit(self)


func on_moving_right(is_right: bool) -> void:
	if is_right:
		animated_sprite_3d.flip_h = false
	else: animated_sprite_3d.flip_h = true
	

func take_damage(amount: float) -> void:
	health_component.take_damage(amount)

func heal_damage(amount: float) -> void:
	health_component.heal(amount)


func go_to(data: Variant) -> void:
	movement_component.go_to(data)
