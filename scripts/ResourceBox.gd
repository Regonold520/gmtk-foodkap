extends Area2D
class_name ResourceBox

## A box. that contains an ingredient

@export var ResourcesHeld : Array[IngredientResource] = []:
	set(type):
		ResourcesHeld = type
		displayItems()

func displayItems() -> void:
	if ResourcesHeld != []:
		$ItemTexture.texture = load("res://assets/ingredients/"+ResourcesHeld[0].Type+".png")
		$Count.text = str(ResourcesHeld.size())
	else:
		$ItemTexture.texture = null
		$Count.text = ""

func grabItemFromTop() -> IngredientResource:
	var item = ResourcesHeld.pop_back()
	displayItems()
	return item
