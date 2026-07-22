extends Node
class_name SelectionManagerNode

## This handles clicking stuff

signal clickedObject(object : Node)

var hoveringObject : Node
@export var selectionObject : Area2D

func _process(delta):
	selectionObject.global_position = selectionObject.get_global_mouse_position()
	
	if selectionObject.has_overlapping_areas():
		hoveringObject = selectionObject.get_overlapping_areas()[0]
		if Input.is_action_just_pressed('select'):
			clickedObject.emit(hoveringObject)


func _on_clicked_object(object : Node):
	print("Clicked ", object, " of type ", object.get_script().get_global_name())
