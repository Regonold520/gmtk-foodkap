extends Node
class_name HoldingManagerNode

## This keeps track of what ingredient is currently held

@export var ItemHeldVisual : Sprite2D

var inHand : IngredientResource = null:
	set(item):
		inHand = item
		if ItemHeldVisual:
			if inHand != null:
				ItemHeldVisual.texture = load("res://assets/ingredients/"+inHand.Type+".png")
				ItemHeldVisual.modulate = inHand.Tint
			else:
				ItemHeldVisual.texture = null

func _on_selection_manager_clicked_object(object : Node):
	if object is ResourceBox:
		if inHand == null:
			if object.ResourcesHeld != []:
				inHand = object.grabItemFromTop()
		else:
			var canInput : bool
			if object.ResourcesHeld != []:
				if object.ResourcesHeld[0].Type == inHand.Type:
					canInput = true
				else:
					canInput = false
			else:
				canInput = true
			if inHand != null and canInput:
				object.ResourcesHeld.append(inHand)
				object.ResourcesHeld = object.ResourcesHeld
				inHand = null
