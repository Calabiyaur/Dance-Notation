extends MarginContainer


var dance: Dance


func _ready() -> void:
	%Back.pressed.connect(func(): go_back())
	%Title.text = dance.name
	%FigureCount.text = str(dance.figures.size())
	%Categories/History.pressed.connect(func():
		SceneSwitcher.switch_to("res://scene/History.tscn", func(scene): scene.set_dance(dance))
	)
	%Categories/Music.pressed.connect(func():
		SceneSwitcher.switch_to("res://scene/Music.tscn", func(scene): scene.set_dance(dance))
	)
	%Categories/Posture.pressed.connect(func():
		SceneSwitcher.switch_to("res://scene/Posture.tscn", func(scene): scene.set_dance(dance))
	)
	%Categories/Figures.pressed.connect(func():
		SceneSwitcher.switch_to("res://scene/Figures.tscn", func(scene): scene.set_dance(dance))
	)


func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		go_back()


func go_back():
	SceneSwitcher.switch_to("res://scene/App.tscn")


func set_dance(dance: Dance):
	self.dance = dance
