extends VBoxContainer


var dance: Dance
var figure: Figure

var step_button_group: ButtonGroup


func _ready() -> void:
	%Back.pressed.connect(func():
		SceneSwitcher.switch_to("res://Figures.tscn", func(scene): scene.set_dance(dance))
	)
	%Title.text = dance.name + "\n" + figure.name
	%Steps/Add.pressed.connect(add_new_step)
	
	step_button_group = ButtonGroup.new()
	step_button_group.allow_unpress = true
	
	for step in figure.steps:
		add_step(step)


func add_step(bistep: BiStep):
	var step = preload("res://BiStep.tscn").instantiate()
	step.get_lead().button_group = step_button_group
	step.get_follow().button_group = step_button_group
	
	step.step = bistep
	
	%Steps.add_child(step)
	%Steps.move_child(step, %Steps.get_child_count() - 2)


func add_new_step():
	var step = preload("res://BiStep.tscn").instantiate()
	step.get_lead().button_group = step_button_group
	step.get_follow().button_group = step_button_group
	
	step.step.lead.right_foot = Foot.new()
	step.step.follow.left_foot = Foot.new()
	
	%Steps.add_child(step)
	%Steps.move_child(step, %Steps.get_child_count() - 2)
	step.get_lead().button_pressed = true
	
	figure.steps.append(step.step)
	Data.save()


func set_dance(dance: Dance):
	self.dance = dance


func set_figure(figure: Figure):
	self.figure = figure
