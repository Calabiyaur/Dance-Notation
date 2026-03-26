extends MarginContainer


var dance_notation: DanceNotation


func _ready() -> void:
	dance_notation = Data.load()
	dance_notation.dances.sort_custom(func(a, b): return a.name < b.name)
	for dance in dance_notation.dances:
		add_dance_button(dance)
	
	%Add.pressed.connect(open_create_dance_dialog)


func add_dance_button(dance: Dance) -> Button:
	var button = Button.new()
	button.text = dance.name
	%Dances.add_child(button)
	button.pressed.connect(func():
		SceneSwitcher.switch_to("res://Dance.tscn", func(scene): scene.set_dance(dance))
	)
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
		dance_notation.dances.append(dance)
		var button = add_dance_button(dance)
		Data.save()
		button.pressed.emit()
	)
	
	add_child(dialog)
	dialog.popup_centered(Vector2i(240, 60))
	
	line.grab_focus()
