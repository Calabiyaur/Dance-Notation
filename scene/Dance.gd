extends MarginContainer


var dance: Dance


func _ready() -> void:
	%Back.pressed.connect(func(): SceneSwitcher.switch_to("res://scene/App.tscn"))
	%Title.text = dance.name
	%Categories/Figures.pressed.connect(func():
		SceneSwitcher.switch_to("res://scene/Figures.tscn", func(scene): scene.set_dance(dance))
	)


func set_dance(dance: Dance):
	self.dance = dance
