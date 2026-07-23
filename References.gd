extends Node

@onready var machineData : Dictionary = parse_json_path("res://datastore/machines.json")

@onready var holdingManager : HoldingManagerNode = get_tree().current_scene.find_child("HoldingManager")
@onready var selectionManager : SelectionManagerNode = get_tree().current_scene.find_child("SelectionManager")

func parse_json_path(path):
	var file := FileAccess.open(path, FileAccess.READ)
	if file:
		var json_text := file.get_as_text()
		file.close()
		var result = JSON.parse_string(json_text)
		if result != null:
			var my_dict : Dictionary = result
			return my_dict
		else:
			push_error("Failed to parse JSON")

func getAverageColorOfImage(texture : Texture2D) -> Color:
	var color := Vector3.ZERO
	var texture_size := texture.get_size()
	var image := texture.get_image()
	
	for y in range(0, texture_size.y):
		for x in range(0, texture_size.x):
			var pixel := image.get_pixel(x, y)
			color += Vector3(pixel.r, pixel.g, pixel.b)
			
	color /= texture_size.x * texture_size.y

	return Color(color.x, color.y, color.z)
