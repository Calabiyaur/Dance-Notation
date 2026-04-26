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
