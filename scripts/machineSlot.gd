extends BaseInteractable
class_name MachineSlot

var item : IngredientResource
var interactable = true
func _ready() -> void:
	Ref.selectionManager.clickedObject.connect(areaClicked)
	
func areaClicked(area : Area2D) -> void:
	if !interactable:
		return
	if area == self:
		#print("its me! machine slot! i do the picking up!")
		if Ref.holdingManager.inHand != null and item == null:
			item = Ref.holdingManager.inHand
			Ref.holdingManager.inHand = null
			#print(" i pick up item?")
		elif Ref.holdingManager.inHand == null and item != null:
			Ref.holdingManager.inHand = item
			item = null

func _process(delta): #due to the volatile nature of machine slots, we will assume it can and will change every frame
	super(delta)
	if item:
		$Food.texture = item.getTexture()
		$Food.modulate = item.Tint
	else:
		$Food.texture = null

func selectable() -> bool:
	if item == null:
		if Ref.holdingManager.inHand != null:
			return true
		return false
	else:
		return interactable
