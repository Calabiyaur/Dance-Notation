extends MarginContainer


var step: BiStep

signal insert_left
signal insert_right
signal move_left
signal move_right
signal delete


func _ready() -> void:
	%More.get_popup().id_pressed.connect(id_pressed)


func id_pressed(id: int):
	match id:
		0: insert_left.emit()
		1: insert_right.emit()
		2: move_left.emit()
		3: move_right.emit()
		4: delete.emit()


func get_lead():
	return %Lead


func get_lead_button():
	return %Lead/%Button


func get_follow():
	return %Follow


func get_follow_button():
	return %Follow/%Button


func get_more():
	return %More
