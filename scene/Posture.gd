extends VBoxContainer


var dance: Dance


func _ready() -> void:
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


func update_edit_state():
	%TechniqueInput.editable = State.edit
	%Text.editable = State.edit


func set_dance(dance: Dance):
	self.dance = dance
