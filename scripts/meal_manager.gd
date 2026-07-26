extends Node
class_name MealManager

## this node stores what meals have been submitted

var meals : Array[IngredientResource] = []

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
	infoPanel.text += "Desired Meal Size: " + Ref.currentDestination.MealSizes.find_key(Ref.currentDestination.DesiredMealSize) + "\n"
	var capitalized_array = Ref.currentDestination.FavoredMeals.map(func(s: String): return s.capitalize())
	infoPanel.text +=  "Favored Meals: " + ", ".join(capitalized_array) + "\n"

func updateAll():
	updateInfoPanel()
	updateMealsRemaining()

func addMeal(meal : IngredientResource):
	meals.append(meal)
	updateMealsRemaining()
