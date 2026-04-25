extends HandPart


func _draw() -> void:
	super._draw()
	
	if step.left_hand:
		draw_hand(step.left_hand, true)


func has_data() -> bool:
	return step.left_hand != null
