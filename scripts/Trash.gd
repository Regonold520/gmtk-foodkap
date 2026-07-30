extends BaseInteractable
class_name Trash

@export var trashParticle : CPUParticles2D

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	Ref.selectionManager.clickedObject.connect(areaClicked)
	
func areaClicked(area : Area2D) -> void:
	if area == self:
		if Ref.holdingManager.inHand != null:
			var item = Ref.holdingManager.inHand
			Ref.holdingManager.inHand = null
			var newParticle = trashParticle.duplicate()
			trashParticle.add_sibling(newParticle)
			newParticle.texture = item.getTexture()
			newParticle.color = item.Tint
			newParticle.emitting = true
			newParticle.finished.connect(newParticle.queue_free)
			await get_tree().create_timer(0.9).timeout
			newParticle.z_index = -1

func selectable() -> bool:
	if !get_child(0).disabled:
		if Ref.holdingManager.inHand != null:
			return true
	return false
