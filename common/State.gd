extends Node


var edit: bool = true: set = set_edit
var dance_tab_index: int = 0

signal edit_changed


func set_edit(value: bool):
	edit = value
	edit_changed.emit()
