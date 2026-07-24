extends Node

@export var theBigOne : Control
@export var arrowLine : Line2D
var display = false
@export var planetScene : PackedScene
@export var constantPlanet : Node2D
@export var Camera : Camera2D
@export var planetDataDisplay : PanelContainer

var circleNodes : Array[Node2D]= []
var NodeToData = {}

var buttonGroup = ButtonGroup

var currentPlanetClicked
var currentPlanetDataHovered
func startSelection():
	var newTween = create_tween()
	newTween.set_ease(Tween.EASE_OUT)
	newTween.set_trans(Tween.TRANS_CIRC)
	newTween.tween_property(theBigOne,"global_position",Vector2.ZERO,0.5)
	display = true
	$"../SelectionManager".running = false
	Camera.active = false
	planetDataDisplay.global_position = Vector2.ONE * 2000
	currentPlanetClicked = null


func _ready():
	get_child(0).visible = true
	startSelection()
	generatePlanets()

func _process(delta):
	if display: 
		if currentPlanetClicked != null:
			arrowLine.set_point_position(1,lerp(arrowLine.get_point_position(1),currentPlanetClicked.global_position,delta*9))
		else:
			arrowLine.set_point_position(1,arrowLine.get_global_mouse_position())

func get_valid_position(min_x, max_x, min_y, max_y) -> Vector2:
	for attempt in 50:
		var pos = Vector2(
			randf_range(min_x, max_x),
			randf_range(min_y, max_y)
		)

		var valid = true
		for planet in circleNodes:
			if planet.position.distance_to(pos) < 150:
				valid = false
				break

		if valid:
			return pos

	# Fallback if no good spot found
	return Vector2(
		randf_range(min_x, max_x),
		randf_range(min_y, max_y)
	)

func generatePlanets(amount = 5,difficulty = 1):
	for I in circleNodes: I.queue_free()
	
	# Ensure there is always a close by planet
	var newPlanet = planetScene.instantiate()
	theBigOne.add_child(newPlanet)
	circleNodes.append(newPlanet)
	newPlanet.position = get_valid_position(464.0,550.0,102,568.0)
	
	# And a faraway one
	newPlanet = planetScene.instantiate()
	theBigOne.add_child(newPlanet)
	circleNodes.append(newPlanet)
	newPlanet.position = Vector2(randf_range(750,988.0),randf_range(102,568.0))
	
	for I in amount - 2:
		newPlanet = planetScene.instantiate()
		theBigOne.add_child(newPlanet)
		circleNodes.append(newPlanet)
		newPlanet.position = get_valid_position(464.0,988.0,102,568.0)
	
	for I in circleNodes:
		I.find_child("Button").button_group = buttonGroup
		I.find_child("Button").pressed.connect(select.bind(I))
	for I in circleNodes:
		var dist = I.global_position.distance_squared_to(constantPlanet.global_position)
		var newData : PlanetData = PlanetData.new(1,dist)
		NodeToData[I] = newData

var cutoffX = 1060
var cutoffY = 600

func select(Selected : PlanetUI):
	currentPlanetClicked = Selected
	planetDataDisplay.visible = false
	var planetData : PlanetData = NodeToData[Selected]
	currentPlanetDataHovered = planetData
	#planetDataDisplay.global_position = Selected.global_position
	var displayText = planetDataDisplay.get_child(0)
	displayText.text = planetData.PlanetName
	displayText.text += "[hr]"  + "\n"
	displayText.text += "Estimated Arrival Time: " + str(planetData.TimeToArrive ) + "\n"
	displayText.text += "Meal Count: " + str(planetData.MealCount)  + "\n"
	displayText.text += "Meal Size: " + str(planetData.MealSizes.find_key(planetData.DesiredMealSize))  + "\n"
	
	await RenderingServer.frame_post_draw
	var outerX = Selected.global_position.x + planetDataDisplay.size.x
	var outerY = Selected.global_position.y + planetDataDisplay.size.y
	planetDataDisplay.global_position = Selected.global_position
	if outerX >= cutoffX:
		var offset = outerX - cutoffX
		planetDataDisplay.global_position.x -= offset
	if outerY >= cutoffY:
		var offset = outerY - cutoffY
		planetDataDisplay.global_position.y -= offset
	planetDataDisplay.visible = true



func _on_select_button_pressed():
	Ref.currentDestination = currentPlanetDataHovered
	$CanvasLayer/Panel/Button.disabled = true
	var newTween = create_tween()
	newTween.set_ease(Tween.EASE_OUT)
	newTween.set_trans(Tween.TRANS_CIRC)
	newTween.tween_property(theBigOne,"global_position",Vector2(0,-652.0),0.5)
	display = false
	$"../SelectionManager".running = true
	Camera.active = true
	planetDataDisplay.global_position = Vector2.ONE * 2000
	$"../MealManager".updateAll()
