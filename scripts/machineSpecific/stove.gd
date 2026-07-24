extends Machine
class_name StoveMachine

func run(_delta = 0) -> void:
	for slot : MachineSlot in slots:
		if slot.item and slot.item.Type != mData["fallbackType"]:
			if !slot.item.has_meta("stove_progress"):
				slot.item.set_meta("stove_progress",0.0)
			slot.item.set_meta("stove_progress",slot.item.get_meta("stove_progress") + _delta/baseRunTime)
			slot.item.Tint = lerp(Color.WHITE,Color.SADDLE_BROWN,slot.item.get_meta("stove_progress"))
			#print("its now ",slot.item.get_meta("stove_progress"), " yayay", baseRunTime)
			slot.find_child("ProgressBar").value = slot.item.get_meta("stove_progress",0)
			
			if slot.item.get_meta("stove_progress") >= 0.5:
				slot.item.addTag("Toasty")
			else:
				slot.item.EffectTags.erase("Toasty")
			
			if slot.item.get_meta("stove_progress") >= 1.0:
				if mData.get("recipes",{}).has(slot.item.Type):
					slot.item.EffectTags.erase("Inedible")
					slot.item.Type = mData["recipes"][slot.item.Type]
					slot.item.Tint = Color.WHITE
					slot.item.set_meta("stove_progress",0.0)
				elif slot.item.get_meta("stove_progress") >= 1.5:
					slot.item.Type = mData["fallbackType"]
					slot.item.Tint = Color.WHITE
					slot.item.set_meta("stove_progress",0.0)
			slot.find_child("Particles").emitting = true
		else:
			slot.find_child("ProgressBar").value = 0
			slot.find_child("Particles").emitting = false
