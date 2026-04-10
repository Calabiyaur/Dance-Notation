extends Button


var dance: Dance
var figure: Figure

signal delete


func _ready() -> void:
	pressed.connect(func():
		SceneSwitcher.switch_to("res://scene/Figure.tscn", func(scene):
			scene.set_dance(dance)
			scene.set_figure(figure)
		)
	)
	%More.get_popup().id_pressed.connect(id_pressed)


func id_pressed(id: int):
	match id:
		0: open_rename_dialog()
		1: delete.emit()


func open_rename_dialog():
	var dialog = AcceptDialog.new()
	dialog.title = "Neuer Name"
	
	var line = LineEdit.new()
	line.text = figure.name
	line.select_all()
	dialog.add_child(line)
	dialog.register_text_enter(line)
	line.text_changed.connect(func(text: String):
		dialog.get_ok_button().disabled = not text
	)
	
	dialog.confirmed.connect(func():
		figure.name = line.text
		text = line.text
		Data.save()
	)
	
	add_child(dialog)
	dialog.popup_centered(Vector2i(280, 60))
	
	line.grab_focus()


func set_dance(dance: Dance):
	self.dance = dance


func set_figure(figure: Figure):
	self.figure = figure
	text = figure.name
