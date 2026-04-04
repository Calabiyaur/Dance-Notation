extends GridContainer


const DIRECTION_VALUES: Array[float] = [1, -1]
const ANGLE_VALUES: Array[float] = [TAU * 0.125, TAU * 0.25]

var step: Step

signal data_changed


func _ready() -> void:
	$Direction.item_selected.connect(direction_selected)
	$Angle.item_selected.connect(angle_selected)


func direction_selected(id: int):
	step.upper_body_rotation = DIRECTION_VALUES[id] * ANGLE_VALUES[$Angle.selected]
	data_changed.emit()


func angle_selected(id: int):
	step.upper_body_rotation = ANGLE_VALUES[id] * DIRECTION_VALUES[$Direction.selected]
	data_changed.emit()


func set_step(step: Step):
	self.step = step
	
	visible = step.upper_body_rotation != 0
	
	$Direction.select(DIRECTION_VALUES.find(sign(step.upper_body_rotation)))
	$Angle.select(ANGLE_VALUES.find(abs(step.upper_body_rotation)))
