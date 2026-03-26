extends VBoxContainer


var dance: Dance
var figure: Figure


func _ready() -> void:
	%Back.pressed.connect(func():
		SceneSwitcher.switch_to("res://Figures.tscn", func(scene): scene.set_dance(dance))
	)
	%Title.text = dance.name + "\n" + figure.name
	%Steps/Add.pressed.connect(add_new_step)


func add_new_step():
	var step = preload("res://BiStep.tscn").instantiate()
	step.step.lead.right_foot = Foot.new()
	step.step.follow.left_foot = Foot.new()
	%Steps.add_child(step)
	%Steps.move_child(step, %Steps.get_child_count() - 2)


func set_dance(dance: Dance):
	self.dance = dance


func set_figure(figure: Figure):
	self.figure = figure
