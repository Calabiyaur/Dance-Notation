extends MarginContainer


var step: Step

signal data_changed


func _ready() -> void:
	visible = step != null
	
	%BodyActive.toggled.connect(func(value: bool):
		step.body_rotation = TAU * 0.25 if value else 0.0
		%BodyInput.set_step(step)
		data_changed.emit()
	)
	%LeftFootActive.toggled.connect(func(value: bool):
		step.left_foot = Foot.new() if value else null
		%LeftFootInput.set_foot(step.left_foot)
		%RightFootActive.disabled = value
		data_changed.emit()
	)
	%RightFootActive.toggled.connect(func(value: bool):
		step.right_foot = Foot.new() if value else null
		%RightFootInput.set_foot(step.right_foot)
		%LeftFootActive.disabled = value
		data_changed.emit()
	)
	
	%BodyInput.data_changed.connect(func(): data_changed.emit())
	%RightFootInput.data_changed.connect(func(): data_changed.emit())
	%RightFootInput.data_changed.connect(func(): data_changed.emit())


func set_step(step: Step):
	self.step = step
	visible = step != null and State.edit
	if not step:
		return
	
	%BodyActive.set_pressed_no_signal(step.body_rotation != 0)
	%LeftFootActive.set_pressed_no_signal(step.left_foot != null)
	%RightFootActive.set_pressed_no_signal(step.right_foot != null)
	
	%LeftFootActive.disabled = step.right_foot != null
	%RightFootActive.disabled = step.left_foot != null
	
	%BodyInput.set_step(step)
	%LeftFootInput.set_foot(step.left_foot)
	%RightFootInput.set_foot(step.right_foot)
