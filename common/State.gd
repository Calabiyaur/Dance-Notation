extends Node


var edit: bool = true: set = set_edit
var dance_tab_index: int = 0: set = set_dance_tab_index

signal edit_changed


func set_edit(value: bool):
	edit = value
	edit_changed.emit()


func set_dance_tab_index(value: int):
	dance_tab_index = value
