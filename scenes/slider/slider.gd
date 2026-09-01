extends Control
class_name CustomSlider

signal value_changed(value: float)

@export var min_value: float = 0.0
@export var max_value: float = 1.0
@export var  value: float = 0.5:
	set(new_value):
		value = clamp(new_value, min_value, max_value)
		_update_grabber_position()
		value_changed.emit(value)

@export var track_texture: Texture2D
@export var grabber_texture: Texture2D
@export var grabber_area_texture: Texture2D
@export var end_cap_width: float = 22

@onready var track: NinePatchRect = $TrackTexture
@onready var grabber_area: NinePatchRect = $GrabberArea
@onready var grabber: TextureRect = $Grabber

var dragging: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if track_texture:
		track.texture = track_texture
	if grabber_texture:
		grabber.texture = grabber_texture
	if grabber_area_texture:
		grabber_area.texture = grabber_area_texture
		
	grabber.mouse_filter = Control.MOUSE_FILTER_STOP
	grabber.gui_input.connect(_on_grabber_input)
	track.mouse_filter = Control.MOUSE_FILTER_STOP
	track.gui_input.connect(_on_track_input)
	
	_update_grabber_position()


func _on_grabber_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed



func _on_track_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_set_value_from_mouse_x(event.position.x)
		dragging = true


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		dragging = false
	elif event is InputEventMouseMotion and dragging:
		_set_value_from_mouse_x(track.get_local_mouse_position().x)


func _set_value_from_mouse_x(mouse_x: float) -> void:
	var min_x = (end_cap_width - grabber.size.x) / 2.0
	var max_x = track.size.x - end_cap_width / 2.0 - grabber.size.x / 2.0
	var ratio = clamp((mouse_x - grabber.size.x / 2.0 - min_x) / (max_x - min_x), 0.0, 1.0)
	value = min_value + ratio * (max_value - min_value)


func _update_grabber_position() -> void:
	if not track or not grabber:
		return
	var ratio = (value - min_value) / (max_value - min_value)
	var min_x = (end_cap_width - grabber.size.x) / 2.0
	var max_x = track.size.x - end_cap_width / 2.0 - grabber.size.x / 2.0
	grabber.position.x = min_x + ratio * (max_x - min_x)
	grabber.position.y = (track.size.y - grabber.size.y) / 2.0
	
	grabber_area.size.x = grabber.position.x + grabber.size.x
	grabber_area.size.y = track.size.y
	grabber_area.position.y = 0
	
