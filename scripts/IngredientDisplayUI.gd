extends Control
class_name IngredientDisplayControlNode

@export var Name : Label
@export var icon : TextureRect

@export var tagSep : HSeparator
@export var tags : RichTextLabel

func display(item : IngredientResource):
	Name.text = item.getDisplayName()
	icon.texture = item.getTexture()
	if item.EffectTags.size() > 0:
		tagSep.visible = true
		tags.visible = true
		
		var text = ""
		for I in item.EffectTags:
			text += I
			text += "\n"
		
		tags.text = text
		
	else:
		tagSep.visible = false
		tags.visible = false
