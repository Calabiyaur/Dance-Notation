extends MarginContainer


var step: Step: set = set_step

@onready var parts = [%LeftBracket, %UpperBody, %Foot, %Body, %RightBracket]


func set_step(value: Step):
	step = value
	
	for part: Part in parts:
		part.step = value


func _draw() -> void:
	for part: Part in parts:
		part.queue_redraw()
