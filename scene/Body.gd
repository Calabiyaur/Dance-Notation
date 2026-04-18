extends Part


func _draw() -> void:
	super._draw()
	if has_data():
		draw_rotation(Vector2(0, -0.5), step.body_rotation)


func has_data() -> bool:
	return step.body_rotation != 0
