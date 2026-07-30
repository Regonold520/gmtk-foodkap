extends BaseInteractable
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
		$Node2D/Count.text = str(ResourcesHeld.size())
	else:
		$ItemTexture.texture = null
		$Node2D/Count.text = ""

func grabItemFromTop() -> IngredientResource:
	var item = ResourcesHeld.pop_back()
	displayItems()
	return item

func addItemToTop(item : IngredientResource):
	ResourcesHeld.append(item)
	displayItems()

func selectable() -> bool:
	if is_instance_valid( Ref.holdingManager):
		if ResourcesHeld.size() == 0:
			if canRecieveNewItemsIfEmpty and Ref.holdingManager.inHand:
				return true
			return false
		else:
			var haveType = ResourcesHeld[0].Type
			if Ref.holdingManager.inHand:
				if Ref.holdingManager.inHand.Type == haveType:
					return true
			else:
				return true
			return false
	else:
		return false
	
