extends Sprite2D
class_name PlanetUI

@export var PlanetTexture : TextureRect
var noiseTexture : NoiseTexture2D 
func _ready():
	noiseTexture = PlanetTexture.texture
	var colorRamp : Gradient = noiseTexture.color_ramp
	var waterLike = Color(randf(), randf(), randf())
	colorRamp.set_color(0,waterLike)
	colorRamp.set_color(1,waterLike)
	colorRamp.set_color(2,Color.from_hsv(waterLike.h+0.5,waterLike.s,waterLike.v))
	noiseTexture.noise.seed = randi()

func _process(delta):
	noiseTexture.noise.offset += Vector3(delta * 6,delta,0)
