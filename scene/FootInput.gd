extends GridContainer


const DIRECTION_VALUES: Array[float] = [
	TAU * 0.25, TAU * 0.375, TAU * 0.5, TAU * 0.625,
	TAU * 0.75, TAU * 0.875, 0, TAU * 0.125
]
const LENGTH_VALUES: Array[float] = [0, 0.5, 1, 1.5]

var foot: Foot

signal data_changed


func _ready() -> void:
	$Length.item_selected.connect(length_selected)
	$Direction.item_selected.connect(direction_selected)


func length_selected(id: int):
	foot.length = LENGTH_VALUES[id]
	$Direction.visible = foot.length != 0
	data_changed.emit()


func direction_selected(id: int):
	foot.direction = DIRECTION_VALUES[id]
	data_changed.emit()


func set_foot(foot: Foot):
	self.foot = foot
	
	visible = foot != null
	
	if foot:
		$Length.select(LENGTH_VALUES.find(foot.length))
		$Direction.select(DIRECTION_VALUES.find(foot.direction))
		
		$Direction.visible = foot.length != 0
