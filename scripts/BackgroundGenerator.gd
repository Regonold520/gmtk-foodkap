@tool
extends Node2D
class_name BgGenerator

@export var constantSlice : Sprite2D
@export var extraSliceContainer : Node2D
@export var noiseTexture : TextureRect
@export var back : Sprite2D

var lastX = 0

@export var segments = 0:
	set(val):
		segments = val
		generate()

func generate():
	if extraSliceContainer:
		for I in extraSliceContainer.get_children(): if I != constantSlice: I.queue_free()
		if constantSlice:
			lastX = 0
			for I in segments:
				var newSlice = constantSlice.duplicate()
				newSlice.global_position.x -= newSlice.texture.get_width() * (I + 1)
				extraSliceContainer.add_child(newSlice)
				lastX = newSlice.global_position.x
			noiseTexture.global_position.x = lastX - constantSlice.texture.get_width() * 0.5
			noiseTexture.size.x = constantSlice.texture.get_width() * (segments + 1)
			back.global_position.x = lastX

func _ready():
	if !Engine.is_editor_hint():
		$BackBackground.visible = true
	generate()
