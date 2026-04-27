extends MarginContainer


var dance: Dance


func _ready() -> void:
	%Back.pressed.connect(func():
		go_back()
	)
	%Title.text = "Haltung - " + dance.name
	
	%TechniqueInput.text = dance.posture.technique
	%TechniqueInput.text_changed.connect(func(text):
		dance.posture.technique = text
		Data.save()
	)
	
	%Text.text = dance.posture.text
	%Text.text_changed.connect(func():
		dance.posture.text = %Text.text
		Data.save()
	)
	
	State.edit_changed.connect(update_edit_state)
	update_edit_state()


func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		go_back()


func go_back():
	SceneSwitcher.switch_to("res://scene/Dance.tscn", func(scene): scene.set_dance(dance))


func update_edit_state():
	%TechniqueInput.editable = State.edit
	%Text.editable = State.edit


func set_dance(dance: Dance):
	self.dance = dance
