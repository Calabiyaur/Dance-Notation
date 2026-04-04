extends FormatSpinBox


const DURATION_VALUES: Array[float] = [1, 0.75, 0.5, 0.25]


var data: Step

signal data_changed


func _ready() -> void:
	super._ready()
	value_changed.connect(duration_selected)


func duration_selected(value: float):
	data.duration = value
	data_changed.emit()


func set_data(data: Step):
	self.data = data
	
	if data:
		set_value_no_signal(data.duration)
