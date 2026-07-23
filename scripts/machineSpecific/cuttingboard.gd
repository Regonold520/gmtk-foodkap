extends Machine
class_name CuttingBoardMachine

@export var anim : AnimationPlayer

func run(_delta = 0) -> void:
	for slot in slots:
		if slot.item:
			if slot.interactable:
				slot.interactable = false
				find_child("Particles").color = Ref.getAverageColorOfImage(slot.item.getTexture())
			if !slot.item.has_meta("cutting_progress"):
				slot.item.set_meta("cutting_progress",0.0)
			slot.item.set_meta("cutting_progress",slot.item.get_meta("cutting_progress") + _delta/baseRunTime)
			slot.find_child("ProgressBar").value = slot.item.get_meta("cutting_progress")
			if slot.item.get_meta("cutting_progress") >= 1.0:
				Running = false
				slot.find_child("ProgressBar").value = 0.0
				slot.interactable = true
				if mData["recipes"].has(slot.item.Type):
					slot.item.Type = mData["recipes"][slot.item.Type]
				else:
					slot.item.addTag("Cut")
		else:
			Running = false

func _process(delta):
	super(delta)
	find_child("Particles").emitting = Running
	if anim:
		if Running:
			anim.play("work",1)
		else:
			anim.play("idle",1)
