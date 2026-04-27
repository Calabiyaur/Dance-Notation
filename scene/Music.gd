extends MarginContainer


var dance: Dance


func _ready() -> void:
	%TimeInput.text = dance.music.time
	%TimeInput.text_changed.connect(func(text):
		dance.music.time = text
		Data.save()
	)
	
	%BpmInput.text = dance.music.beats_per_minute
	%BpmInput.text_changed.connect(func(text):
		dance.music.beats_per_minute = text
		Data.save()
	)
	
	%Text.text = dance.music.text
	%Text.text_changed.connect(func():
		dance.music.text = %Text.text
		Data.save()
	)
	
	State.edit_changed.connect(update_edit_state)
	update_edit_state()


func update_edit_state():
	%TimeInput.editable = State.edit
	%BpmInput.editable = State.edit
	%Text.editable = State.edit


func set_dance(dance: Dance):
	self.dance = dance
