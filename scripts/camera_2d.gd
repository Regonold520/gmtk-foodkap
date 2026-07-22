extends Camera2D

@onready var wantedX = global_position.x
@export var cameraSpeed = 10

func _process(delta):
	wantedX += Input.get_axis("camera_left","camera_right") * cameraSpeed
	global_position.x = lerp(global_position.x,wantedX,delta * 20)
