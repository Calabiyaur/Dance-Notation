extends Button


var dance: Dance
var figure: Figure


func _ready() -> void:
	pressed.connect(func():
		SceneSwitcher.switch_to("res://scene/Figure.tscn", func(scene):
			scene.set_dance(dance)
			scene.set_figure(figure)
		)
	)


func set_dance(dance: Dance):
	self.dance = dance


func set_figure(figure: Figure):
	self.figure = figure
	text = figure.name
