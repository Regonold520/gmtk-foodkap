extends Node
class_name SelectionManagerNode

## This handles clicking stuff

signal clickedObject(object : Node)

var hoveringObject : Node
@export var selectionObject : Area2D

@export var hoveringOverObjectDescriptor : IngredientDisplayControlNode 


var running = true

func _ready():
	print("hi im selection manager im setting myself")
	Ref.selectionManager = self

func _process(delta):
	if !running: return
	selectionObject.global_position = selectionObject.get_global_mouse_position()
	
	if selectionObject.has_overlapping_areas():
		hoveringObject = selectionObject.get_overlapping_areas()[0]
		if Input.is_action_just_pressed('select'):
			clickedObject.emit(hoveringObject)
	else:
		hoveringObject = null
	
	if hoveringObject:
		var selectedItem : IngredientResource = null
		if "item" in hoveringObject: if hoveringObject.item is IngredientResource: selectedItem = hoveringObject.item
		if "ResourcesHeld" in hoveringObject: if hoveringObject.ResourcesHeld.size() != 0: if hoveringObject.ResourcesHeld.get(0) is IngredientResource: selectedItem = hoveringObject.ResourcesHeld.get(0)
		if selectedItem != null:
			hoveringOverObjectDescriptor.display(selectedItem)
			hoveringOverObjectDescriptor.visible = true
		else:
			hoveringOverObjectDescriptor.visible = false
	else:
		hoveringOverObjectDescriptor.visible = false


func _on_clicked_object(object : Node):
	print("Clicked ", object, " of type ", object.get_script().get_global_name())
