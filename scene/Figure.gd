extends VBoxContainer


var dance: Dance
var figure: Figure

var step_button_group: ButtonGroup


func _ready() -> void:
	%Back.pressed.connect(func():
		go_back()
	)
	%Title.text = figure.name + "\n" + dance.name
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


func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		go_back()


func go_back():
	SceneSwitcher.switch_to("res://scene/Figures.tscn", func(scene): scene.set_dance(dance))


func add_step(bistep: BiStep):
	var step = append_step()
	step.step = bistep
	step.get_lead().step = bistep.lead
	step.get_follow().step = bistep.follow


func add_new_step(index: int = -1):
	var step = append_step(index)
	
	var bistep = BiStep.new()
	
	step.step = bistep
	step.get_lead().step = bistep.lead
	step.get_follow().step = bistep.follow
	
	step.get_lead().button_pressed = true
	
	figure.steps.insert(index, bistep)
	Data.save()


func append_step(index: int = -1):
	var step = preload("res://scene/BiStep.tscn").instantiate()
	
	%Steps.add_child(step)
	%Steps.move_child(step, %Steps.get_child_count() - 2
			if index == -1 else index)
	
	for s: Button in [step.get_lead(), step.get_follow()]:
		s.button_group = step_button_group
		s.toggled.connect(func(value: bool):
			%Details.set_step(s.step if value else null)
		)
	
	step.insert_left.connect(func():
		var i = figure.steps.find(step.step)
		add_new_step(i)
	)
	step.insert_right.connect(func():
		var i = figure.steps.find(step.step) + 1
		add_new_step(i)
	)
	step.move_left.connect(func():
		var i = posmod(figure.steps.find(step.step) - 1, figure.steps.size())
		%Steps.move_child(step, i)
		figure.steps.erase(step.step)
		figure.steps.insert(i, step.step)
	)
	step.move_right.connect(func():
		var i = (figure.steps.find(step.step) + 1) % figure.steps.size()
		%Steps.move_child(step, i)
		figure.steps.erase(step.step)
		figure.steps.insert(i, step.step)
	)
	step.delete.connect(func():
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
