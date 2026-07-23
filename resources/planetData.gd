extends Resource
class_name PlanetData

var MealCount : int
var TimeToArrive : float
var PlanetName : String = ""

var letters := "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("")
var numbers := "1234567890".split("")

func _init(difficulty = 0, distance = 0) -> void:
	var time = distance * 0.00027207059
	var meals = int((time / 30) * 5**(difficulty/0.98))
	TimeToArrive = round(time)
	MealCount = meals
	PlanetName = letters.get(randi_range(0,letters.size()-1))+"-"+letters.get(randi_range(0,letters.size()-1))+letters.get(randi_range(0,letters.size()-1))+numbers.get(randi_range(0,numbers.size()-1))+numbers.get(randi_range(0,numbers.size()-1))
