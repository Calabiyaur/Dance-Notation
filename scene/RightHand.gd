extends HandPart


func _draw() -> void:
	super._draw()
	
	if step.right_hand:
		draw_hand(step.right_hand, false)


func has_data() -> bool:
	return step.right_hand != null
