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
	%Details.visible = false
	
	step_button_group = ButtonGroup.new()
	step_button_group.allow_unpress = true
	
	for step in figure.steps:
		add_step(step)


func add_step(bistep: BiStep):
	var step = append_step()
	step.step = bistep


func add_new_step():
	var step = append_step()
	
	step.step.lead.right_foot = Foot.new()
	step.step.follow.left_foot = Foot.new()
	
	step.get_lead().button_pressed = true
	
	figure.steps.append(step.step)
	Data.save()


func append_step():
	var step = preload("res://BiStep.tscn").instantiate()
	
	%Steps.add_child(step)
	%Steps.move_child(step, %Steps.get_child_count() - 2)
	
	for s: Button in [step.get_lead(), step.get_follow()]:
		s.button_group = step_button_group
		s.toggled.connect(func(value: bool): select(s.step if value else null))
	
	return step


func select(step: Step):
	%Details.visible = true if step else false
	if not step:
		return
	
	


func set_dance(dance: Dance):
	self.dance = dance


func set_figure(figure: Figure):
	self.figure = figure
