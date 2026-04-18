extends Part


func _draw() -> void:
	super._draw()
	if has_data():
		draw_rotation(Vector2(0, 0.5), step.upper_body_rotation)


func has_data() -> bool:
	return step.upper_body_rotation != 0
