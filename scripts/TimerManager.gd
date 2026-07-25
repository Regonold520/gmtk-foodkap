extends Node

var timer = Timer.new()
var secondsTimer = Timer.new()

@export var progress : Range

var secondsTick = preload("res://sfx/dragon-studio-slow-cinematic-clock-ticking-357979.mp3")

func _ready():
	add_child(timer)
	add_child(secondsTimer)
	timer.one_shot = true
	secondsTimer.wait_time = 1.0
	secondsTimer.timeout.connect(secondPassed)
func startTimer(time):
	timer.wait_time = time
	timer.start()
	timer.timeout.connect(timerFinished)
	secondsTimer.start()

func timerFinished():
	$CanvasLayer/ColorRect.visible = true
	secondsTimer.stop()
	$FreesoundCommunityGong92707.play()
	await get_tree().create_timer(2).timeout
	$"../DayEndManager".endDay()

func format_time(total_seconds: int) -> String:
	var minutes: int = total_seconds / 60
	var seconds: int = total_seconds % 60
	return "%02d:%02d" % [minutes, seconds]

func secondPassed():
	var timePercentRemaining = 1-inverse_lerp(timer.wait_time,0,timer.time_left)
	print(inverse_lerp(0.25,0,timePercentRemaining))
	if timePercentRemaining <= 0.25:
		var newStream = AudioStreamPlayer2D.new()
		add_child(newStream)
		newStream.stream = secondsTick
		newStream.play()
		newStream.volume_linear = inverse_lerp(0.25,0,timePercentRemaining)

func _process(delta):
	progress.value = timer.time_left
	progress.max_value = timer.wait_time
	progress.get_child(0).text = format_time(timer.time_left)
	var timePercentRemaining = 1-inverse_lerp(timer.wait_time,0,timer.time_left)
	progress.get_child(0).offset_transform_scale = Vector2.ONE.max(inverse_lerp(timer.wait_time,0,timer.time_left) * Vector2.ONE * 5)
	
