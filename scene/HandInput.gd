extends GridContainer


const DIRECTION_VALUES: Array[float] = [
	TAU * 0.25, TAU * 0.375, TAU * 0.5, TAU * 0.625,
	TAU * 0.75, TAU * 0.875, 0, TAU * 0.125
]
const LENGTH_VALUES: Array[float] = [0, 0.5, 1]

var hand: Hand

signal data_changed


func _ready() -> void:
	$Length.item_selected.connect(length_selected)
	$Direction.item_selected.connect(direction_selected)


func length_selected(id: int):
	hand.length = LENGTH_VALUES[id]
	var direction_was_invisible = not $Direction.visible
	$Direction.visible = hand.length != 0
	if direction_was_invisible:
		$Direction.select(0)
		hand.direction = DIRECTION_VALUES[0]
	data_changed.emit()


func direction_selected(id: int):
	hand.direction = DIRECTION_VALUES[id]
	data_changed.emit()


func set_hand(hand: Hand):
	self.hand = hand
	
	visible = hand != null
	
	if hand:
		$Length.select(LENGTH_VALUES.find(hand.length))
		$Direction.select(DIRECTION_VALUES.find(hand.direction))
		
		$Direction.visible = hand.length != 0
	
	if not $Direction.visible:
		$Direction.select(0)
