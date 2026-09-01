extends Control

@onready var options_menu: Panel = $OptionsMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Start game
func _on_start_pressed() -> void:
	pass # Replace with function body.


# Open options menu
func _on_options_pressed() -> void:
	pass # Replace with function body.


# Terminate game
func _on_exit_pressed() -> void:
	get_tree().quit()
