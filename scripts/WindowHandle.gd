extends Area2D
class_name WindowHandle

var windowOpen = false

@export var trashClickzone : Area2D

func _ready() -> void:
	Ref.selectionManager.clickedObject.connect(areaClicked)
	
func areaClicked(area : Area2D) -> void:
	if area == self:
		windowOpen = !windowOpen
		var newTween = create_tween()
		if windowOpen:
			newTween.tween_property(get_parent().get_parent(),"offset_transform_position",Vector2(0,-110),0.8)
		else:
			newTween.set_ease(Tween.EASE_OUT)
			newTween.set_trans(Tween.TRANS_BOUNCE)
			newTween.tween_property(get_parent().get_parent(),"offset_transform_position",Vector2(0,0),0.8)
		trashClickzone.get_child(0).disabled = !windowOpen
