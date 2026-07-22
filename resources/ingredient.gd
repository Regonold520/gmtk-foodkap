extends Resource
class_name IngredientResource

## A resource that refers to an Ingredient item (an a item that can be either but into a machine, or served to a customer). Has a main 'type', alongside modifiers

## Type is the string that... refers to the type. Also used for visuals
@export var Type : String = ""

## QualityModifier Refers to the increased quality of the food
@export var QualityModifier : float = 1.0
