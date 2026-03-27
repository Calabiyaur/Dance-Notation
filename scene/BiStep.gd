extends MarginContainer


var step: BiStep

signal delete_pressed


func _ready() -> void:
	%More.get_popup().id_pressed.connect(id_pressed)


func id_pressed(id: int):
	match id:
		0: delete_pressed.emit()


func get_lead():
	return %Lead


func get_follow():
	return %Follow


func get_more():
	return %More
