extends BaseInteractable
class_name MachineStarter

func _ready() -> void:
	Ref.selectionManager.clickedObject.connect(areaClicked)
	
func areaClicked(area : Area2D) -> void:
	if area == self:
		get_parent().Running = true

func selectable() -> bool:
	if get_parent().Running:
		return false
	else:
		return get_parent().visual_can_start()
