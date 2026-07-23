extends Camera2D

@onready var wantedX = global_position.x
@export var cameraSpeed = 10

@export var maxX = 30.0

@export var BG : BgGenerator

func _process(delta):
	wantedX += Input.get_axis("camera_left","camera_right") * cameraSpeed
	wantedX = min(wantedX,maxX)
	wantedX = max(wantedX,BG.lastX - 180)
	global_position.x = lerp(global_position.x,wantedX,delta * 20)
