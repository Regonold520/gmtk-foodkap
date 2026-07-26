extends Control
class_name IngredientDisplayControlNode

@export var Name : Label
@export var icon : TextureRect

@export var tagSep : HSeparator
@export var tags : RichTextLabel

func display(item : IngredientResource):
	Name.text = item.getDisplayName()
	icon.texture = item.getTexture()
	var itemData = Ref.ingredientData.get(item.Type)

	
	$PanelContainer/VBoxContainer/PortionSize.text = "Portion Size: " + str(Ref.currentDestination.MealSizes.find_key(int(itemData.get("size",0)))) 
	$PanelContainer/VBoxContainer/Rating.text = str(itemData.get("rating",0)) + " / 5.0"
	$PanelContainer/VBoxContainer/Flavor.text = itemData.get("flavorText","")
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
