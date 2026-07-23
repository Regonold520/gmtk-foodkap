extends Machine
class_name BlenderMachine

func run(_delta = 0) -> void:
	find_child("Visual").offset = Vector2.from_angle(randf_range(-PI,PI)) * 8
	for slot in slots:
		if slot.item:
			if slot.interactable:
				slot.interactable = false
				find_child("Particles").color = Ref.getAverageColorOfImage(load("res://assets/ingredients/"+slot.item.Type+".png"))
			slot.get_child(1).visible = false
			if !slot.item.has_meta("blender_progress"):
				slot.item.set_meta("blender_progress",0.0)
			slot.item.set_meta("blender_progress",slot.item.get_meta("blender_progress") + _delta/baseRunTime)
			slot.find_child("ProgressBar").value = slot.item.get_meta("blender_progress")
			if slot.item.get_meta("blender_progress") >= 1.0:
				Running = false
				slot.find_child("ProgressBar").value = 0.0
				slot.get_child(1).visible = true
				slot.interactable = true
				if mData["recipes"].has(slot.item.Type):
					slot.item.Type = mData["recipes"][slot.item.Type]
				else:
					slot.item.Type = mData["fallbackType"]
				slot.item.EffectTags.erase("Cut")
				slot.item.set_meta("blender_progress",0.0)
		else:
			Running = false

func _process(delta):
	super(delta)
	find_child("Particles").emitting = Running
