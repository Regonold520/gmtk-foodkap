extends Node
class_name MealManager

## this node stores what meals have been submitted

var meals : Array[MealManager] = []

@export var RemainingLabel : Label
@export var infoPanel : RichTextLabel

func calculateMealsRemaining():
	if Ref.currentDestination:
		return Ref.currentDestination.MealCount - meals.size()
	else:
		return 0

func updateMealsRemaining():
	RemainingLabel.text = str(calculateMealsRemaining())

func updateInfoPanel():
	infoPanel.text = ""
	infoPanel.text += "Destination: " + Ref.currentDestination.PlanetName
	infoPanel.text += "\n"
	infoPanel.text += "Desired Meal Size: " + Ref.currentDestination.MealSizes.find_key(Ref.currentDestination.DesiredMealSize)
	infoPanel.text += "Favored Foods: "
