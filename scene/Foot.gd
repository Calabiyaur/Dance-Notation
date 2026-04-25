extends Part


func _draw() -> void:
	super._draw()
	
	if step.left_foot:
		draw_foot(step.left_foot, true)
	if step.right_foot:
		draw_foot(step.right_foot, false)
	if not step.left_foot and not step.right_foot and not State.edit:
		draw_pause()
	
	if step.duration != 1:
		draw_duration()


func has_data() -> bool:
	return true


func draw_foot(foot: Foot, flip: bool):
	var offset: Vector2 = Vector2(-0.4, 0)
	
	var points: PackedVector2Array = [
		Vector2.DOWN,
		Vector2.RIGHT,
		Vector2.UP,
		Vector2.DOWN
	]
	
	for i in points.size():
		points[i] = center + (points[i] + offset) * SCALE \
				* Vector2(-1 if flip else 1, 1)
	
	draw_polyline(points, COLOR, LINE_WIDTH)
	
	if foot.length > 0:
		var line_from = Vector2.UP if foot.direction <= TAU * 0.5 \
				else Vector2.DOWN
		line_from += -offset if flip else offset
		
		var line_to = line_from + foot.length * Vector2(
			cos(foot.direction),
			-sin(foot.direction)
		)
		
		line_from = center + line_from * SCALE
		line_to = center + line_to * SCALE
		
		draw_line(line_from, line_to, COLOR, LINE_WIDTH)


func draw_pause():
	var rect_size = SCALE / 2
	var rect = Rect2(center - rect_size / 2, rect_size)
	draw_rect(rect, COLOR, false, LINE_WIDTH)


func draw_duration():
	var xs: Array[float]
	var filled: Array[bool]
	match step.duration:
		0.25:
			xs = [0]
			filled = [true]
		0.5:
			xs = [-0.16, 0.16]
			filled = [true, true]
		0.75:
			xs = [-0.25, 0, 0.25]
			filled = [true, true, true]
		1.25:
			xs = [-0.16, 0.16]
			filled = [false, true]
		1.5:
			xs = [-0.25, 0, 0.25]
			filled = [false, true, true]
		1.75:
			xs = [-0.3, -0.1, 0.1, 0.3]
			filled = [false, true, true, true]
		2.0:
			xs = [-0.16, 0.16]
			filled = [false, false]
	
	for i in xs.size():
		var c = center + Vector2(xs[i], 0) * SCALE
		draw_circle(c, LINE_WIDTH - 0.5, COLOR, filled[i], LINE_WIDTH * 0.25, true)
