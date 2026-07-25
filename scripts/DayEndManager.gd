extends Node
class_name DayEndManager

@export var mealManager : MealManager

func endDay():
	var ratingsAndComments = calculateRating()
	var rating = ratingsAndComments[0]
	var comments = ratingsAndComments[1]

func calculateRating():
	var curPlanet := Ref.currentDestination
	var ratings = [5,5,5,5] #we start with a few fives as the 'making the game easier at the start' bonus. as more meals get made, the less important these are.
	var comments = []
	var mealsNeeded = curPlanet.MealCount
	for Item : IngredientResource in mealManager.meals:
		mealsNeeded -= 1
		var itemData = Ref.ingredientData.get(Item.Type,{})
		var PortionSizeModifier = 1.0
		if itemData.get("size",-999) != curPlanet.DesiredMealSize:
			PortionSizeModifier = 0.75
		
		var InedibleModifier = 1.0
		if Item.EffectTags.has("Inedible"):
			InedibleModifier = 0.25
			comments.append(["My food (%) was Inedible!" ,"I couldn't eat my %!","...how am I supposed to eat %?" ].pick_random() % Item.Type.capitalize() )
		
		var FavoredModifier = 1.0
		if Item.Type in curPlanet.FavoredMeals:
			FavoredModifier = 2.5
			comments.append(["The % was DELECTABLE!!", "I LOVE %!!"].pick_random() % Item.Type.capitalize())
		
		var modifier = Item.QualityModifier*FavoredModifier*InedibleModifier*PortionSizeModifier*randf_range(0.9,1.0)
		var FinalRating = clamp(modifier * float(itemData.get("rating",3)),0,5)
		ratings.append(FinalRating)
	for i in mealsNeeded: #for any orders left empty
		ratings.append(0)
	return [getAverageOfArray(ratings),comments]

func getAverageOfArray(arr : Array[float]) -> float:
	var num = 0
	for I in arr:
		num += I
	return num / arr.size()
