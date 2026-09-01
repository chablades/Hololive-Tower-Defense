extends Control

@onready var options_menu: Panel = $OptionsMenu
@onready var main_menu_layer: CanvasLayer = $MainMenuLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.options_back.connect(on_options_back_pressed)


# Start game
func _on_start_pressed() -> void:
	pass # Replace with function body.


# Open options menu
func _on_options_pressed() -> void:
	options_menu.show()
	main_menu_layer.hide()


# Terminate game
func _on_exit_pressed() -> void:
	get_tree().quit()


func on_options_back_pressed() -> void:
	options_menu.hide()
	main_menu_layer.show()
