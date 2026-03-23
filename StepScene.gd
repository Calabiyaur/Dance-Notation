extends Button


var step: Step


func _draw() -> void:
	var center: Vector2 = size / 2
	if step.right_foot:
		center.x -= 10
	if step.left_foot:
		center.x += 10
	
	var foot_points: PackedVector2Array = []
	if step.right_foot:
		foot_points.append_array([center + Vector2(0, 20), center + Vector2(0, -20), center + Vector2(20, 0), center + Vector2(0, 20)])
	if step.left_foot:
		foot_points.append_array([center + Vector2(0, 20), center + Vector2(0, -20), center + Vector2(-20, 0), center + Vector2(0, 20)])
	
	if foot_points.size() > 0:
		draw_polyline(foot_points, Color.WHITE, 2)
