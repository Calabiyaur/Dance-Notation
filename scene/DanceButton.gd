extends Button


var dance: Dance


func _ready() -> void:
	pressed.connect(func():
		SceneSwitcher.switch_to("res://scene/Dance.tscn", func(scene): scene.set_dance(dance))
	)


func set_dance(dance: Dance):
	self.dance = dance
	text = dance.name
	%Count.text = str(dance.figures.size()) + " - " + str(dance.choreos.size())
