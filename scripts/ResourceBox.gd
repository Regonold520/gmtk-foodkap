extends Area2D
class_name ResourceBox

## A box. that contains an ingredient

@export var ResourcesHeld : Array[IngredientResource] = []:
	set(type):
		ResourcesHeld = type
		$ItemTexture.texture = load("res://assets/ingredients/kaplin.png") #change later
