extends Area2D
class_name Trash

@export var trashParticle : CPUParticles2D

func _ready() -> void:
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
