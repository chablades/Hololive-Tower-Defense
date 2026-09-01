extends Panel

@onready var bgm_slider: CustomSlider = $Panel/VBoxContainer/BGM/Slider

var bgm_audio_bus_id: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bgm_audio_bus_id = AudioServer.get_bus_index("Music")


func _on_bgm_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(bgm_audio_bus_id, db)
