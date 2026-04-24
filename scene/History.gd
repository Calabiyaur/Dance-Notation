extends MarginContainer


var dance: Dance


func _ready() -> void:
	%Back.pressed.connect(func():
		go_back()
	)
	%Title.text = "Geschichte - " + dance.name
	%Edit.set_pressed_no_signal(State.edit)
	%Edit.toggled.connect(func(value: bool):
		State.edit = value
		update_edit_state()
	)
	
	%OriginInput.text = dance.history.origin
	%OriginInput.text_changed.connect(func(text):
		dance.history.origin = text
		Data.save()
	)
	
	%Text.text = dance.history.text
	%Text.text_changed.connect(func():
		dance.history.text = %Text.text
		Data.save()
	)
	
	update_edit_state()


func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		go_back()


func go_back():
	SceneSwitcher.switch_to("res://scene/Dance.tscn", func(scene): scene.set_dance(dance))


func update_edit_state():
	%Edit.text = "Ansehen" if State.edit else "Bearbeiten"
	%OriginInput.editable = State.edit
	%Text.editable = State.edit


func set_dance(dance: Dance):
	self.dance = dance
