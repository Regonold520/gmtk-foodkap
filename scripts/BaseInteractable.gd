extends Area2D
class_name BaseInteractable

var interactableIconScene = load("res://scenes/interactableIcon.tscn")
var interactableIcon = null

func _process(delta: float) -> void:
	if !is_instance_valid(interactableIcon):
		interactableIcon = interactableIconScene.instantiate()
		add_child(interactableIcon)
		interactableIcon.visible = false
		interactableIcon.get_child(0).play("default")
	interactableIcon.visible = selectable()

func selectable() -> bool:
	return true
