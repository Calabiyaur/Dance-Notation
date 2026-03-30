extends Button


const COLOR = Color.WHITE
const LINE_WIDTH = 2
const SCALE = Vector2(20, 20)

var step: Step

var center: Vector2


func _draw() -> void:
	center = size / 2
	
	if step.duration != 1:
		draw_duration()
	
	if step.body_rotation != 0:
		draw_body_rotation()
	
	if step.left_foot:
		draw_foot(step.left_foot, true)
	if step.right_foot:
		draw_foot(step.right_foot, false)
	if not step.left_foot and not step.right_foot and not State.edit:
		draw_pause()


func draw_duration():
	var xs: Array[float] = []
	match step.duration:
		0.25: xs.append(0)
		0.5: xs.append_array([-0.16, 0.16])
		0.75: xs.append_array([-0.25, 0, 0.25])
	
	for x in xs:
		var c = center + Vector2(x, 0) * SCALE
		draw_circle(c, LINE_WIDTH, COLOR, true)


func draw_duration_line(): # unused alternative to draw_duration
	var offset: Vector2 = Vector2(
		-0.6 if step.left_foot else -0.4 if step.right_foot else 0,
		0
	)
	offset.x += step.duration
	var from: Vector2 = center + (Vector2.UP * 0.5 + offset) * SCALE
	var to: Vector2 = center + (Vector2.DOWN * 0.5 + offset) * SCALE
	draw_line(from, to, COLOR, LINE_WIDTH)


func draw_body_rotation():
	var c = center + Vector2(0, 2.5) * SCALE
	match step.body_rotation:
		TAU * -0.625: c.x -= 0.05 * SCALE.x
		TAU * -0.5: c.x -= 0.25 * SCALE.x
		TAU * -0.375, \
		TAU * -0.25: c.x -= 0.3 * SCALE.x
		TAU * -0.125: c.x -= 0.25 * SCALE.x
		TAU * 0.125: c.x += 0.25 * SCALE.x
		TAU * 0.25, \
		TAU * 0.375: c.x += 0.3 * SCALE.x
		TAU * 0.5: c.x += 0.25 * SCALE.x
		TAU * 0.625: c.x += 0.05 * SCALE.x
	
	var r = SCALE.x * 0.5
	var angle = TAU * -0.25 - step.body_rotation
	
	draw_arc(
		c,
		r,
		TAU * -0.25,
		angle,
		16,
		COLOR,
		LINE_WIDTH
	)
	
	var tip_offset_angle = angle - TAU * 0.25 * sign(step.body_rotation)
	var tip_offset = 2 * LINE_WIDTH * Vector2(cos(tip_offset_angle), sin(tip_offset_angle))
	var tip_origin = c + r * Vector2(cos(angle), sin(angle)) + tip_offset
	var tip_length = 0.375 * SCALE.x
	var tip_angle_1 = angle + TAU * 0.33 * sign(step.body_rotation)
	var tip_angle_2 = angle + TAU * 0.17 * sign(step.body_rotation)
	var tip: PackedVector2Array = [
		tip_origin + tip_length * Vector2(cos(tip_angle_1), sin(tip_angle_1)),
		tip_origin,
		tip_origin + tip_length * Vector2(cos(tip_angle_2), sin(tip_angle_2))
	]
	
	draw_colored_polygon(tip, COLOR)


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
	var rect = Rect2(center - SCALE / 2, SCALE)
	draw_rect(rect, COLOR, false, LINE_WIDTH)
