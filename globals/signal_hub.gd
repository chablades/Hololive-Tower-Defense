extends Node

signal options_back


func on_options_back_pressed() -> void:
	options_back.emit()
	
