class_name Part
extends ColorRect


const COLOR = Color.WHITE
const LINE_WIDTH = 2
const SCALE = Vector2(20, 20)

var step: Step

var center: Vector2


func _draw() -> void:
	center = size / 2


func has_data() -> bool:
	return false


func draw_rotation(offset: Vector2, rotation: float):
	var c = center + offset * SCALE
	match rotation:
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
	var angle = TAU * -0.25 - rotation
	
	draw_arc(
		c,
		r,
		TAU * -0.25,
		angle,
		16,
		COLOR,
		LINE_WIDTH
	)
	
	var tip_offset_angle = angle - TAU * 0.25 * sign(rotation)
	var tip_offset = 2 * LINE_WIDTH * Vector2(cos(tip_offset_angle), sin(tip_offset_angle))
	var tip_origin = c + r * Vector2(cos(angle), sin(angle)) + tip_offset
	var tip_length = 0.375 * SCALE.x
	var tip_angle_1 = angle + TAU * 0.33 * sign(rotation)
	var tip_angle_2 = angle + TAU * 0.17 * sign(rotation)
	var tip: PackedVector2Array = [
		tip_origin + tip_length * Vector2(cos(tip_angle_1), sin(tip_angle_1)),
		tip_origin,
		tip_origin + tip_length * Vector2(cos(tip_angle_2), sin(tip_angle_2))
	]
	
	draw_colored_polygon(tip, COLOR)
