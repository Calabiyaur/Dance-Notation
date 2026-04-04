class_name FormatSpinBox
extends SpinBox


func _ready() -> void:
	get_line_edit().focus_mode = Control.FOCUS_NONE


func _process(delta: float) -> void:
	var text = (prefix + "%s" + suffix) % value
	if get_line_edit().text != text:
		get_line_edit().text = text
