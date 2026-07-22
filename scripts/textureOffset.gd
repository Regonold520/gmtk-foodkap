extends Sprite2D

func _process(delta):
	if texture:
		offset.y = -(texture.get_size().y / 2)
