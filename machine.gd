extends Node2D
class_name Machine

var baseRunTime : float = 1.0
var currentTime : float = 0.0

var inputs : Array[IngredientResource] = []
var output : IngredientResource = null

var maxInputs : int = 1

var id : String = ""

func loadData() -> void:
	var mData = Ref.machineData[id]
	
	baseRunTime = Ref.machineData[id]["runTime"]
	maxInputs = Ref.machineData[id]["inputCount"]

func addInput(target : IngredientResource) -> bool:
	if inputs.size() < maxInputs:
		inputs.append(target)
		return true
	
	return false

func run() -> void:
	pass

func getRunTime() -> float:
	return baseRunTime
