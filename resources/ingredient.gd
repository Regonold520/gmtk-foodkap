extends Resource
class_name IngredientResource

## A resource that refers to an Ingredient item (an a item that can be either but into a machine, or served to a customer). Has a main 'type', alongside modifiers

## Type is the string that... refers to the type. Also used for visuals
@export var Type : String = ""

## QualityModifier Refers to the increased quality of the food
@export var QualityModifier : float = 1.0

## Refers to any sort of modulation on the object
@export var Tint : Color = Color.WHITE

## EffectTags are special things that can be added by certain machines. For example, not fully cooking something will give it the 'toasty' effect tag, which might be more ideal.
@export var EffectTags : Array[String] = []


func addTag(tag : String):
	if !EffectTags.has(tag):
		EffectTags.append(tag)
