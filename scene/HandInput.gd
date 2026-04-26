extends GridContainer


const TARGET_VALUES: Array[bool] = [false, true] #TODO: Enum
const HEIGHT_VALUES: Array[float] = [0, 1, -1]
const DIRECTION_VALUES: Array[float] = [
	0, # dummy value in case of no selection
	TAU * 0.25, TAU * 0.375, TAU * 0.5, TAU * 0.625,
	TAU * 0.75, TAU * 0.875, 0, TAU * 0.125
]

var hand: Hand

signal data_changed


func _ready() -> void:
	$Target.item_selected.connect(target_selected)
	$Height.item_selected.connect(height_selected)
	$Direction.item_selected.connect(direction_selected)


func target_selected(id: int):
	hand.target = TARGET_VALUES[id]
	data_changed.emit()


func height_selected(id: int):
	hand.height = HEIGHT_VALUES[id]
	data_changed.emit()


func direction_selected(id: int):
	hand.length = 0 if id == 0 else 1
	hand.direction = DIRECTION_VALUES[id]
	data_changed.emit()


func set_hand(hand: Hand):
	self.hand = hand
	
	visible = hand != null
	
	if hand:
		$Target.select(TARGET_VALUES.find(hand.target))
		$Height.select(HEIGHT_VALUES.find(hand.height))
		$Direction.select(DIRECTION_VALUES.find(hand.direction, 1) if hand.length > 0 else 0)
