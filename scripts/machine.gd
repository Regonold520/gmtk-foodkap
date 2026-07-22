extends Node2D
class_name Machine

var baseRunTime : float = 1.0
var fallback := ""

@export var slots : Array[MachineSlot] = []
@export var id : String = ""

@export var alwaysRun = false
var mData : Dictionary
func _ready():
	loadData()

func loadData() -> void:
	mData = Ref.machineData[id]
	baseRunTime = mData["runTime"]
	fallback = mData["fallbackType"]

func run(_delta = 0) -> void:
	pass

func getRunTime() -> float:
	return baseRunTime

func _process(delta):
	if alwaysRun:
		run(delta)
