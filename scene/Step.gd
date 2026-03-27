extends Button


const COLOR = Color.WHITE
const LINE_WIDTH = 2
const SCALE = Vector2(20, 20)

var step: Step

var center: Vector2


func _draw() -> void:
	center = size / 2
	
	if step.left_foot:
		draw_foot(step.left_foot, true)
	if step.right_foot:
		draw_foot(step.right_foot, false)
	if not step.left_foot and not step.right_foot and not State.edit:
		draw_pause()


func draw_pause():
	var rect = Rect2(center - SCALE / 2, SCALE)
	draw_rect(rect, COLOR, false, LINE_WIDTH)


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
		var line_from = Vector2.UP if foot.direction in [0, 1, 2, 6, 7] \
				else Vector2.DOWN
		line_from += -offset if flip else offset
		
		var angle = (foot.direction + 2) / 8.0 * TAU
		var line_to = line_from + 0.5 * foot.length * Vector2(
			cos(angle),
			-sin(angle)
		)
		
		line_from = center + line_from * SCALE
		line_to = center + line_to * SCALE
		
		draw_line(line_from, line_to, COLOR, LINE_WIDTH)
