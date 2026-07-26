extends Node

@export var slots : Array[ResourceBox] = []

func addItem(itemType):
	for I in slots:
		if I.ResourcesHeld.size() == 0 or I.ResourcesHeld.get(0).get("Type") == itemType:
			for C in range(3):
				var newIngredient = IngredientResource.new()
				newIngredient.Type = itemType
				I.addItemToTop(newIngredient)
			return

func _ready():
	addItem("grain")
	addItem("grain")
	addItem("grain")
