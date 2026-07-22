extends Node
class_name MachineListManagerNode

## A node with the sole purpose of keeping track what machines exist, where, and what to do about em

@export var BackgroundGenerator : BgGenerator

var machineListString : Array[String] = []
var machineListNodes : Array[Machine] = []

@export var spacing = -41

func addMachine(machineName):
	
	var node = load("res://scenes/machines/"+machineName+".tscn").instantiate()
	add_sibling.call_deferred(node)
	if machineListNodes == []:
		node.global_position = Vector2(365,185)
	else:
		node.global_position = machineListNodes[-1].global_position
		node.global_position.x += Ref.machineData[machineListString[-1]]["width"] * spacing * 2
	machineListNodes.append(node)
	machineListString.append(machineName)
	
	var slotSize = 0.0
	for I in machineListString:
		slotSize += Ref.machineData[I]["width"]
	BackgroundGenerator.segments = int(slotSize*0.96) + 2

func _ready():
	addMachine("stove")
	addMachine("stove")
	addMachine("stove")

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		addMachine("stove")
