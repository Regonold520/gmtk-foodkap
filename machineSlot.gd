extends Area2D
class_name MachineSlot

func _ready() -> void:
	Ref.selectionManager.clickedObject.connect(areaClicked)
	
func areaClicked(area : Area2D) -> void:
	if area == self:
		print("erio")
