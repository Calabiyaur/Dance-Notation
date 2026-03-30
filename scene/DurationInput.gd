extends OptionButton


const DURATION_VALUES: Array[float] = [1, 0.75, 0.5, 0.25]


var step: Step

signal data_changed


func _ready() -> void:
	item_selected.connect(duration_selected)


func duration_selected(id: int):
	step.duration = DURATION_VALUES[id]
	data_changed.emit()


func set_step(step: Step):
	self.step = step
	
	if step:
		select(DURATION_VALUES.find(step.duration))
