extends MarginContainer


var dance: Dance


func _ready() -> void:
	%Back.pressed.connect(func():
		SceneSwitcher.switch_to("res://scene/Dance.tscn", func(scene): scene.set_dance(dance))
	)
	%Title.text = dance.name + " - Figuren"
	%Add.pressed.connect(open_create_figure_dialog)
	
	dance.figures.sort_custom(func(a, b): return a.name < b.name)
	for figure in dance.figures:
		add_figure_button(figure)


func add_figure_button(figure: Figure) -> Button:
	var button = Button.new()
	button.text = figure.name
	%Figures.add_child(button)
	button.pressed.connect(func():
		SceneSwitcher.switch_to("res://scene/Figure.tscn", func(scene):
			scene.set_dance(dance)
			scene.set_figure(figure)
		)
	)
	return button


func open_create_figure_dialog():
	var dialog = AcceptDialog.new()
	dialog.title = "Create a new figure"
	dialog.get_ok_button().disabled = true
	
	var line = LineEdit.new()
	dialog.add_child(line)
	dialog.register_text_enter(line)
	line.text_changed.connect(func(text: String):
		dialog.get_ok_button().disabled = not text
	)
	
	dialog.confirmed.connect(func():
		var figure = Figure.new()
		figure.name = line.text
		dance.figures.append(figure)
		var button = add_figure_button(figure)
		Data.save()
		button.pressed.emit()
	)
	
	add_child(dialog)
	dialog.popup_centered(Vector2i(240, 60))
	
	line.grab_focus()


func set_dance(dance: Dance):
	self.dance = dance
