extends MarginContainer


var data: Data


func _ready() -> void:
	data = Data.load()
	data.dances.sort_custom(func(a, b): return a.name < b.name)
	for dance in data.dances:
		add_dance_button(dance)
	
	%Add.pressed.connect(open_create_dance_dialog)


func add_dance_button(dance: Dance) -> Button:
	var button = preload("res://scene/DanceButton.tscn").instantiate()
	button.set_dance(dance)
	%Dances.add_child(button)
	return button


func open_create_dance_dialog():
	var dialog = AcceptDialog.new()
	dialog.title = "Create a new dance"
	dialog.get_ok_button().disabled = true
	
	var line = LineEdit.new()
	dialog.add_child(line)
	dialog.register_text_enter(line)
	line.text_changed.connect(func(text: String):
		dialog.get_ok_button().disabled = not text
	)
	
	dialog.confirmed.connect(func():
		var dance = Dance.new()
		dance.name = line.text
		data.dances.append(dance)
		var button = add_dance_button(dance)
		Data.save()
		button.pressed.emit()
	)
	
	add_child(dialog)
	dialog.popup_centered(Vector2i(240, 60))
	
	line.grab_focus()
