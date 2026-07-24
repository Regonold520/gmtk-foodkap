extends Area2D
class_name ResourceBox

## A box. that contains an ingredient

@export var canRecieveNewItemsIfEmpty = true

@export var ResourcesHeld : Array[IngredientResource] = []:
	set(type):
		ResourcesHeld = type
		displayItems()

func _ready():
	ResourcesHeld = ResourcesHeld.duplicate(true)
	displayItems()

func displayItems() -> void:
	#print("hi! im display item", name," and i have", ResourcesHeld, "And size is ", ResourcesHeld.size())
	if ResourcesHeld.size() != 0:
		$ItemTexture.texture = ResourcesHeld[0].getTexture()
		$Count.text = str(ResourcesHeld.size())
	else:
		$ItemTexture.texture = null
		$Count.text = ""

func grabItemFromTop() -> IngredientResource:
	var item = ResourcesHeld.pop_back()
	displayItems()
	return item

func addItemToTop(item : IngredientResource):
	ResourcesHeld.append(item)
	displayItems()
