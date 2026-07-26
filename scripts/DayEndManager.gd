extends Node
class_name DayEndManager

@export var MONEY = 500

@export var mealManager : MealManager
@export var percentageDisplay : Label
@export var financeDisplay : RichTextLabel
@export var ReviewLabels : Array[Label]

var moneyPerMeal = 50

@export var machineChoices : Array[Button]
var loss = false
func endDay():
	$"../SelectionManager".running = false
	$"../Camera2D".active = false
	loss = false
	var newTween = create_tween()
	newTween.set_ease(Tween.EASE_OUT)
	newTween.set_trans(Tween.TRANS_QUAD)
	newTween.tween_property($CanvasLayer/Control,"position",Vector2.ZERO,0.5)
	
	var ratingsAndComments = calculateRating()
	var rating = ratingsAndComments[0]
	var comments = ratingsAndComments[1]
	var mealsNeeded = ratingsAndComments[2]
	var perfectRatings = ratingsAndComments[3]
	
	var OrderPlacementMoney = Ref.currentDestination.MealCount * moneyPerMeal
	var MissedMealPenalty = -int(round(mealsNeeded * moneyPerMeal * 1.25))
	var Tips = perfectRatings * 30
	var totalGain = OrderPlacementMoney + MissedMealPenalty + Tips
	MONEY += totalGain
	
	percentageDisplay.text = str(round(inverse_lerp(0,5,rating) * 100)) + "%"
	financeDisplay.text = ""
	financeDisplay.text += "Order Placements [right]"
	financeDisplay.text += "+" + str(OrderPlacementMoney) + "$ [left]"
	financeDisplay.text += "Missed Orders [right]"
	if MissedMealPenalty < 0:
		financeDisplay.text += str(MissedMealPenalty) + "$ [left]"
	if MissedMealPenalty == 0:
		financeDisplay.text += str(MissedMealPenalty) + "$ [left]"
	financeDisplay.text += "Tips [right]"
	if Tips > 0:
		financeDisplay.text += "+" + str(Tips) + "$ [left]"
	else:
		financeDisplay.text += str(Tips) + "$ [left]"
	financeDisplay.text += "[hr] [br]"
	
	if totalGain > 0:
		financeDisplay.text += "Today: +" + str(totalGain) + "$"  
	else:
		financeDisplay.text += "Today: " + str(totalGain) + "$"  
	financeDisplay.text += "[br] TOTAL FUNDS: " + str(MONEY) + "$"  
	#Order Placements [right]+300$ [left]Missed Orders [right]-50$
	#[left]Tips[right]+30$
	#[hr]
	#Today: +30$
	#[b]TOTAL: 300$
	var selectedComments = []
	for I in range(4):
		var chosen = comments.pick_random()
		comments.erase(chosen)
		selectedComments.append(chosen)
		
	var X = 0
	for I in ReviewLabels:
		var stuff = selectedComments.get(X)
		if stuff:
			I.text = selectedComments.get(X)
		else:
			I.text = ""
		X+= 1
	
	$CanvasLayer/Control/DayReport.visible = true
	$CanvasLayer/Control/ChooseDevice.visible = false
	$CanvasLayer/Control/ChooseIngredients.visible = false
	
	if round(inverse_lerp(0,5,rating) * 100) <= 50:
		loss = true

func calculateRating():
	var curPlanet := Ref.currentDestination
	var ratings : Array[float] = [5,5,5,5] #we start with a few fives as the 'making the game easier at the start' bonus. as more meals get made, the less important these are.
	var comments = []
	var mealsNeeded = curPlanet.MealCount
	var perfectRatings = 0
	for Item : IngredientResource in mealManager.meals:
		if !Item:
			continue
		mealsNeeded -= 1
		var itemData = Ref.ingredientData.get(Item.Type,{})
		var PortionSizeModifier = 1.0
		if itemData.get("size",-999) != curPlanet.DesiredMealSize:
			PortionSizeModifier = 0.75
		
		var InedibleModifier = 1.0
		if Item.EffectTags.has("Inedible"):
			InedibleModifier = 0.25
			comments.append(["My food (%s) was Inedible!" ,"I couldn't eat my %s!","...how am I supposed to eat %s?" ].pick_random() % Item.Type.capitalize() )
		
		var FavoredModifier = 1.0
		if Item.Type in curPlanet.FavoredMeals:
			FavoredModifier = 2.5
			comments.append(["The %s was DELECTABLE!!", "I LOVE %s!!"].pick_random() % Item.Type.capitalize())
		elif itemData.get("rating",3) <= 2:
			comments.append(["%s is lowkey disgusting...", "Why %s?","%s tastes yucky!"].pick_random() % Item.Type.capitalize())
		
		var modifier = Item.QualityModifier*FavoredModifier*InedibleModifier*PortionSizeModifier*randf_range(0.9,1.0)
		var FinalRating = clamp(modifier * float(itemData.get("rating",3)),0,5)
		if FinalRating >= 4.5: perfectRatings += 1
		ratings.append(FinalRating)
	for i in mealsNeeded: #for any orders left empty
		comments.append(["I didn't get any food!!!","Hey. Like. Wheres the food?","WHERES MY ORDER??","Can I have food..?"].pick_random())
		ratings.append(0)
	return [getAverageOfArray(ratings),comments,mealsNeeded,perfectRatings]

func getAverageOfArray(arr : Array[float]) -> float:
	var num = 0
	for I in arr:
		num += I
		
	return num / arr.size()


func on_Report_button_clicked():
	
	if loss:
		$CanvasLayer/Control/Loss.visible = true
		return
	
	
	$CanvasLayer/Control/DayReport.visible = false
	$CanvasLayer/Control/ChooseDevice.visible = true
	
	var machineChoiceOptions = []
	while machineChoiceOptions.size() < 3:
		var newChoice = Ref.machineData.keys().pick_random()
		if !machineChoiceOptions.has(newChoice):
			machineChoiceOptions.append(newChoice)
	
	var X = 0
	for I in machineChoices:
		if I.pressed.is_connected(machineSelected):
			I.pressed.disconnect(machineSelected)
		I.icon = load("res://assets/machines/" +machineChoiceOptions[X]+ ".png")
		I.text = machineChoiceOptions[X].capitalize()
		I.pressed.connect(machineSelected.bind(machineChoiceOptions[X]))
		X += 1

var buttons = []
func machineSelected(type):
	$CanvasLayer/Control/ChooseDevice.visible = false
	$CanvasLayer/Control/ChooseIngredients.visible = true
	$"../MachineListManager".addMachine(type)
	
	var validIngredients = []
	for I in Ref.ingredientData:
		if Ref.ingredientData[I].get("baseIngredient",false):
			validIngredients.append(I)
	var selectedValidIngredients = []
	for I in range(5):
		selectedValidIngredients.append(validIngredients.pick_random())
	
	
	for I in $CanvasLayer/Control/ChooseIngredients/Panel/VBoxContainer.get_children(): I.queue_free()
	buttons = []
	
	for I in selectedValidIngredients:
		var newThing = CheckBox.new()
		newThing.text = I.capitalize() + " x 3"
		newThing.set_meta("item",I)
		newThing.icon = load("res://assets/ingredients/"+I+".png")
		newThing.expand_icon = true
		newThing.add_theme_constant_override("outline_size",14)
		newThing.add_theme_font_size_override("font_size",38)
		newThing.size_flags_vertical = Control.SIZE_EXPAND_FILL 
		$CanvasLayer/Control/ChooseIngredients/Panel/VBoxContainer.add_child(newThing)
		buttons.append(newThing)
		newThing.pressed.connect(updatePrices)
	updatePrices()
	await $CanvasLayer/Control/ChooseIngredients/Button.pressed
	var boxesHit = 0
	var ingredientsToAdd = []
	for I : CheckBox in $CanvasLayer/Control/ChooseIngredients/Panel/VBoxContainer.get_children():
		if I.button_pressed:
			boxesHit += 1
			ingredientsToAdd.append(I.get_meta("item"))
	
	var price = boxesHit * 30
	MONEY -= price
	for I in ingredientsToAdd:
		$"../DeepFreezerManager".addItem(I)
	$"../TimerStuff/CanvasLayer/ColorRect".visible = false
	$CanvasLayer/Control/ChooseIngredients.visible = false
	var newTween = create_tween()
	newTween.tween_property($CanvasLayer/Control,"position",Vector2(1,651.0),0.5)
	$"../SelectorUIManager".startSelection()
	mealManager.meals.clear()

func updatePrices():
	var boxesHit = 0
	for I : CheckBox in $CanvasLayer/Control/ChooseIngredients/Panel/VBoxContainer.get_children():
		if I.button_pressed:
			boxesHit += 1
	
	var price = boxesHit * 30
	$CanvasLayer/Control/ChooseIngredients/Price.text = "Price: " + str(int(price))
	$CanvasLayer/Control/ChooseIngredients/FundsBefore.text = "Your funds before: " + str(MONEY)
	$CanvasLayer/Control/ChooseIngredients/FundsAfter.text = "Your funds after: " + str(int(MONEY - price))
	
	if MONEY - price < 0:
		$CanvasLayer/Control/ChooseIngredients/Button.disabled = true
	else:
		$CanvasLayer/Control/ChooseIngredients/Button.disabled = false
