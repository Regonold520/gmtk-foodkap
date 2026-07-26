extends Machine
class_name MixerMachine

func run(_delta = 0) -> void:
	for slot in slots:
		if !slot.item:
			Running = false
	if Running:
		var doneMixing = false
		find_child("Visual").offset = Vector2.from_angle(randf_range(-PI,PI)) * 1
		for slot in slots:
			if slot.item:
				if slot.interactable:
					slot.interactable = false
					find_child("Particles").color = Ref.getAverageColorOfImage(load("res://assets/ingredients/"+slot.item.Type+".png"))
				slot.get_child(1).visible = false
				if !slot.item.has_meta("mixer_progress"):
					slot.item.set_meta("mixer_progress",0.0)
				slot.item.set_meta("mixer_progress",slot.item.get_meta("mixer_progress") + _delta/baseRunTime)
				$ProgressBar.value = slot.item.get_meta("mixer_progress")
				if slot.item.get_meta("mixer_progress") >= 1.0:
					Running = false
					doneMixing = true
			else:
				Running = false
		if doneMixing:
			var result = mData["fallbackType"]
			for res in mData.get("recipesResultKey",{}):
				var ingredients = mData["recipesResultKey"][res]
				var matching = true
				for slot in slots:
					slot.get_child(1).visible = true
					if not (slot.item.Type in ingredients):
						matching = false
				if matching:
					result = res
			var newItem = IngredientResource.new()
			newItem.Type = result
			for i in slots:
				for e in i.item.EffectTags:
					newItem.addTag(e)
			newItem.EffectTags.erase("Cut")
			for slot in slots:
				slot.interactable = true
				slot.item = null
			slots[0].item = newItem
			
	else:
		$ProgressBar.value = 0

func _process(delta):
	super(delta)
	find_child("Particles").emitting = Running
