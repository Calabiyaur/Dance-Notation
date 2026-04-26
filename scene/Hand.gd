class_name HandPart
extends Part


func _draw() -> void:
	super._draw()


func draw_hand(hand: Hand, flip: bool):
	var offset: Vector2 = Vector2(0.4 if flip else -0.4, 0) * SCALE
	
	draw_ellipse_arc(
		center + offset,
		SCALE.x,
		SCALE.y * 0.5,
		TAU * 0.25,
		TAU * 0.75 if flip else TAU * -0.25,
		16,
		COLOR,
		LINE_WIDTH
	)
	
	if hand.target:
		draw_line(
			center + Vector2(offset.x, (SCALE.y + LINE_WIDTH) * -0.5),
			center + Vector2(offset.x, (SCALE.y + LINE_WIDTH) * 0.5),
			COLOR,
			LINE_WIDTH
		)
	
	if hand.height:
		draw_arc(
			center + SCALE * Vector2(-1, -1 if hand.height > 0 else 1) * 0.25,
			SCALE.x * 0.25,
			0,
			TAU * 0.25 if hand.height > 0 else TAU * -0.25,
			8,
			COLOR,
			LINE_WIDTH
		)
		draw_arc(
			center + SCALE * Vector2(1, -1 if hand.height > 0 else 1) * 0.25,
			SCALE.x * 0.25,
			TAU * 0.5,
			TAU * 0.25 if hand.height > 0 else TAU * 0.75,
			8,
			COLOR,
			LINE_WIDTH
		)
