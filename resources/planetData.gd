extends Resource
class_name PlanetData

enum MealSizes {Small, Medium, Large}

var MealCount : int
var TimeToArrive : float
var PlanetName : String = ""
var DesiredMealSize : MealSizes
var FavoredMeals = []

var _letters := "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("")
var _numbers := "1234567890".split("")

func _init(difficulty = 0, distance = 0) -> void:
	var time = distance * 0.00027207059
	var meals = int((time / 30) * 5**(difficulty/0.98))
	TimeToArrive = round(time)
	MealCount = meals
	PlanetName = _letters.get(randi_range(0,_letters.size()-1))+"-"+_letters.get(randi_range(0,_letters.size()-1))+_letters.get(randi_range(0,_letters.size()-1))+_numbers.get(randi_range(0,_numbers.size()-1))+_numbers.get(randi_range(0,_numbers.size()-1))
	DesiredMealSize = randi_range(0,2) as MealSizes
	
	var mealOptions = Ref.ingredientData.keys()
	mealOptions.erase("burntScraps")
	mealOptions.erase("mix")
	while FavoredMeals.size() < 2:
		var thinkingMeal = mealOptions.pick_random()
		if !Ref.ingredientData[thinkingMeal].get("tags",[]).has("Inedible"):
			mealOptions.erase(thinkingMeal)
			FavoredMeals.append(thinkingMeal)
