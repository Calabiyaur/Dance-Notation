extends Part


func _draw() -> void:
	super._draw()
	if has_data():
		draw_arc(
			Vector2(center.x - 120, 48),
			120,
			TAU * -0.06,
			0,
			8,
			COLOR,
			LINE_WIDTH
		)
		draw_line(
			Vector2(center.x, 48),
			Vector2(center.x, size.y - 48),
			COLOR, LINE_WIDTH
		)
		draw_arc(
			Vector2(center.x - 120, size.y - 48),
			120,
			0,
			TAU * 0.06,
			8,
			COLOR,
			LINE_WIDTH
		)


func has_data() -> bool:
	return step.precondition
