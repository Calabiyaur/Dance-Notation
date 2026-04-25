extends CheckBox


var data: Step

signal data_changed


func _ready() -> void:
	toggled.connect(precondition_selected)


func precondition_selected(value: bool):
	data.precondition = value
	data_changed.emit()


func set_data(data: Step):
	self.data = data
	
	if data:
		set_pressed_no_signal(data.precondition)
