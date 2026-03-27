extends VBoxContainer


var dance: Dance
var figure: Figure

var step_button_group: ButtonGroup


func _ready() -> void:
	%Back.pressed.connect(func():
		SceneSwitcher.switch_to("res://scene/Figures.tscn", func(scene): scene.set_dance(dance))
	)
	%Title.text = dance.name + "\n" + figure.name
	%Edit.set_pressed_no_signal(State.edit)
	%Edit.toggled.connect(func(value: bool):
		State.edit = value
		update_edit_state()
	)
	%Steps.focus_entered.connect(func():
		var button = step_button_group.get_pressed_button()
		if button:
			button.set_pressed(false)
	)
	%Steps/Add.pressed.connect(add_new_step)
	%Details.data_changed.connect(func():
		var step = step_button_group.get_pressed_button()
		step.queue_redraw()
		Data.save()
	)
	
	step_button_group = ButtonGroup.new()
	
	for step in figure.steps:
		add_step(step)
	
	update_edit_state()


func add_step(bistep: BiStep):
	var step = append_step()
	step.step = bistep
	step.get_lead().step = bistep.lead
	step.get_follow().step = bistep.follow


func add_new_step():
	var step = append_step()
	
	var bistep = BiStep.new()
	
	step.step = bistep
	step.get_lead().step = bistep.lead
	step.get_follow().step = bistep.follow
	
	step.get_lead().button_pressed = true
	
	figure.steps.append(bistep)
	Data.save()


func append_step():
	var step = preload("res://scene/BiStep.tscn").instantiate()
	
	%Steps.add_child(step)
	%Steps.move_child(step, %Steps.get_child_count() - 2)
	
	for s: Button in [step.get_lead(), step.get_follow()]:
		s.button_group = step_button_group
		s.toggled.connect(func(value: bool):
			%Details.set_step(s.step if value else null)
		)
	
	step.delete_pressed.connect(func():
		%Steps.remove_child(step)
		figure.steps.erase(step.step)
		Data.save()
	)
	
	return step


func update_edit_state():
	%Edit.text = "Ansehen" if State.edit else "Bearbeiten"
	%Steps/Add.visible = State.edit
	for button in %Steps.get_children():
		if button.has_method("get_more"):
			button.get_lead().queue_redraw()
			button.get_follow().queue_redraw()
			button.get_more().visible = State.edit
	%Details.set_step(%Details.step)


func set_dance(dance: Dance):
	self.dance = dance


func set_figure(figure: Figure):
	self.figure = figure
