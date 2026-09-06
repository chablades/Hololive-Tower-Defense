@tool

extends Node

@export_tool_button("Run Mapping") var run_function = _on_tiles_changed
#@export var previous_cells: Dictionary[Vector2i, int] = {}
#@export var previous_coordinates: Array[Vector2i] = []

const HEX_GRASS = preload("uid://bspxi6rdo5qbe")
const HEX_WATER = preload("uid://bnit5meh5k55u")
# Conversion for 2d pixels to 3d meters
# Size of mesh / Size of tile
const PIXEL_TO_METER_RATIO: float = 2.0 / 120.0
const TILE_TO_MESH: Dictionary = {
	0: HEX_WATER,
	1: HEX_GRASS,
}

var _hex_layer: HexagonTileMapLayer
var _hexgrid_3d: Node3D


func _ready() -> void:
	_hex_layer = get_parent() as HexagonTileMapLayer
	if _hex_layer == null:
		push_error("HexagonTileMapLayer parent not found.")
		return
	#previous_coordinates = _hex_layer.get_used_cells()
	#for coordinates in previous_coordinates:
		#previous_cells[coordinates] = _hex_layer.get_cell_source_id(coordinates)

func _on_tiles_changed() -> void:
	print("Running mapping")
	_hexgrid_3d = $"../Hexgrid3D"
	remove_all_child_nodes(_hexgrid_3d)
	var current_cells: Dictionary[Vector2i, int] = {}
	var current_coordinates: Array[Vector2i] = _hex_layer.get_used_cells()
	for coordinates in current_coordinates:
			current_cells[coordinates] = _hex_layer.get_cell_source_id(coordinates)
	
	for coordinates in current_cells:
		var hex_scene: PackedScene = TILE_TO_MESH[current_cells[coordinates]]
		add_child_node(coordinates, hex_scene)
	
	#var added: Dictionary = {}
	#var removed: Dictionary = {}
	#var modified: Dictionary = {}
	#
	#for coordinates in current_cells:
		#if not previous_cells.has(coordinates):
			#added[coordinates] = current_cells[coordinates]
		#elif previous_cells[coordinates] != current_cells[coordinates]:
			#modified[coordinates] = current_cells[coordinates]
		#
	#for coordinates in previous_cells:
		#if not current_cells.has(coordinates):
			#removed[coordinates] = previous_cells[coordinates]
	#
	#print("Added: ", added)
	#print("Removed: ", removed)
	#print("Modified: ", modified)
	#previous_cells = current_cells

func remove_all_child_nodes(node: Node3D) -> void:
	for child in node.get_children():
		child.queue_free()
	
func add_child_node(coordinates: Vector2i, scene: PackedScene) -> void:
	var pixel_pos: Vector2 = _hex_layer.map_to_local(coordinates)
	var world_pos: Vector3 = pixel_position_to_world(pixel_pos)
	var hex_instance: Node = scene.instantiate()
	print(hex_instance)
	_hexgrid_3d.add_child(hex_instance)
	hex_instance.global_position = world_pos
	
func pixel_position_to_world(pixel_pos: Vector2) -> Vector3:
	var world_x: float = pixel_pos.x * PIXEL_TO_METER_RATIO
	var world_z: float = pixel_pos.y * PIXEL_TO_METER_RATIO
	return Vector3(world_x, 0, world_z)
	
	
