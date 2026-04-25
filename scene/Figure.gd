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
	%Steps/Add.item_rect_changed.connect(align_steps)
	%Steps/Add.pressed.connect(add_new_step)
	%Details.data_changed.connect(func():
		align_steps()
		var step = step_button_group.get_pressed_button().get_parent()
		step.queue_redraw()
		Data.save()
	)
	
	step_button_group = ButtonGroup.new()
	
	for step in figure.steps:
		add_step(step)
	
	update_edit_state()
	
	align_steps()


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
	
	step.get_lead_button().button_pressed = true
	
	figure.steps.insert(index if index != -1 else figure.steps.size(),
		bistep)
	Data.save()


func append_step(index: int = -1):
	var step = preload("res://scene/BiStep.tscn").instantiate()
	
	%Steps.add_child(step)
	%Steps.move_child(step, %Steps.get_child_count() - 2
			if index == -1 else index)
	
	for s: Button in [step.get_lead_button(), step.get_follow_button()]:
		s.button_group = step_button_group
		s.toggled.connect(func(value: bool):
			%Details.set_step(s.get_parent().step if value else null)
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
		if %Details.step in [step.step.lead, step.step.follow]:
			%Details.set_step(null)
		Data.save()
	)
	
	return step


func align_steps():
	if %Steps.get_child_count() <= 1:
		return
	
	# collect rows of steps
	var y = -1
	var leads = []
	var follows = []
	var rows = []
	for bistep in %Steps.get_children():
		if not bistep.has_method("get_lead"):
			continue
		if bistep.position.y != y:
			y = bistep.position.y
			if not leads.is_empty():
				rows.append(leads)
				rows.append(follows)
				leads = []
				follows = []
		leads.append(bistep.get_lead())
		follows.append(bistep.get_follow())
	if not leads.is_empty():
		rows.append(leads)
		rows.append(follows)
	
	# show / hide precondition brackets
	var steps = []
	for row in rows:
		steps.append_array(row)
	for i in steps.size():
		var step = steps[i]
		var left_bracket = step.get_node("%LeftBracket")
		var right_bracket = step.get_node("%RightBracket")
		left_bracket.visible = left_bracket.has_data() \
				and (i == 0 or not steps[i - 1].get_node("%RightBracket").has_data())
		right_bracket.visible = right_bracket.has_data() \
				and (i == steps.size() - 1 or not steps[i + 1].get_node("%LeftBracket").has_data())
	
	# show / hide parts
	var parts = ["%LeftHand", "%RightHand", "%UpperBody", "%Foot", "%Body"]
	var show_parts: Array[bool]
	show_parts.resize(parts.size())
	for row in rows:
		show_parts.fill(false)
		for step in row:
			for i in parts.size():
				show_parts[i] = show_parts[i] or step.get_node(parts[i]).has_data()
		for step in row:
			for i in parts.size():
				step.get_node(parts[i]).visible = show_parts[i]


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
