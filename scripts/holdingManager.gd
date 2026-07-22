extends Node
class_name HoldingManagerNode

## This keeps track of what ingredient is currently held

@export var ItemHeldVisual : Sprite2D

var inHand : IngredientResource = null:
	set(item):
		inHand = item
		if ItemHeldVisual:
			ItemHeldVisual.texture = load("res://assets/ingredients/kaplin.png")

func _on_selection_manager_clicked_object(object : Node):
	if object is ResourceBox:
		if inHand == null and object.ResourcesHeld != []:
			inHand = object.ResourcesHeld.pop_front()
