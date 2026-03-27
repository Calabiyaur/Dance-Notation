extends GridContainer


var foot: Foot

signal data_changed


func _ready() -> void:
	$Length.item_selected.connect(length_selected)
	$Direction.item_selected.connect(direction_selected)


func length_selected(id: int):
	foot.length = id
	$Direction.visible = foot.length != 0
	data_changed.emit()


func direction_selected(id: int):
	foot.direction = id
	data_changed.emit()


func set_foot(foot: Foot):
	self.foot = foot
	
	visible = foot != null
	
	if foot:
		$Length.select(foot.length)
		$Direction.select(foot.direction)
		
		$Direction.visible = foot.length != 0
