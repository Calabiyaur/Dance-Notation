extends MarginContainer


var step: Step

signal data_changed


func _ready() -> void:
	visible = step != null
	
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
	
	%LeftFootInput.data_changed.connect(func(): data_changed.emit())
	%RightFootInput.data_changed.connect(func(): data_changed.emit())


func set_step(step: Step):
	self.step = step
	visible = step != null and State.edit
	if not step:
		return
	
	%LeftFootActive.set_pressed_no_signal(step.left_foot != null)
	%RightFootActive.set_pressed_no_signal(step.right_foot != null)
	
	%LeftFootActive.disabled = step.right_foot != null
	%RightFootActive.disabled = step.left_foot != null
	
	%LeftFootInput.set_foot(step.left_foot)
	%RightFootInput.set_foot(step.right_foot)
