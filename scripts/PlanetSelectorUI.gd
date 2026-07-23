extends Node

@export var theBigOne : Control
@export var arrowLine : Line2D
var display = false
@export var planetScene : PackedScene
@export var constantPlanet : Node2D

var circleNodes : Array[Node2D]= []
var NodeToData = {}

var buttonGroup = ButtonGroup



func startSelection():
	var newTween = create_tween()
	newTween.set_ease(Tween.EASE_OUT)
	newTween.set_trans(Tween.TRANS_CIRC)
	newTween.tween_property(theBigOne,"global_position",Vector2.ZERO,0.5)
	display = true
	$"../SelectionManager".running = false



func _ready():
	
	#startSelection()
	generatePlanets()

func _process(delta):
	if display: arrowLine.set_point_position(1,arrowLine.get_global_mouse_position())

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
	for I in circleNodes:
		var dist = I.global_position.distance_squared_to(constantPlanet.global_position)
		var newData : PlanetData = PlanetData.new(1,dist)
		NodeToData[I] = newData
