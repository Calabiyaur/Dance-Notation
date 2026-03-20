extends VBoxContainer


var dance: Dance
var figure: Figure


func _ready() -> void:
	$Header/Back.pressed.connect(func():
		SceneSwitcher.switch_to("res://Figures.tscn", func(scene): scene.set_dance(dance))
	)
	$Header/Title.text = dance.name + "\n" + figure.name


func set_dance(dance: Dance):
	self.dance = dance


func set_figure(figure: Figure):
	self.figure = figure
