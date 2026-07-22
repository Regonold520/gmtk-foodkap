extends Area2D
class_name ResourceBox

## A box. that contains an ingredient

@export var ResourceHeld : IngredientResource = null:
	set(type):
		ResourceHeld = type
		$ItemTexture.texture = load("res://assets/ingredients/kaplin.png") #change later
@export var Count : int = 0:
	set(amount):
		Count = amount
		$Count.text = str(int(Count))
