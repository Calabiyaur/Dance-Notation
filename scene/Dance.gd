extends MarginContainer


var dance: Dance


func _ready() -> void:
	%Back.pressed.connect(func(): go_back())
	%Title.text = dance.name
	
	%Edit.set_pressed_no_signal(State.edit)
	%Edit.toggled.connect(State.set_edit)
	State.edit_changed.connect(update_edit_state)
	update_edit_state()
	
	#%Tabs.set_tab_title(0, "Figuren (" + str(dance.figures.size()) + ")")


func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		go_back()


func go_back():
	SceneSwitcher.switch_to("res://scene/App.tscn")


func update_edit_state():
	%Edit.text = "Ansehen" if State.edit else "Bearbeiten"


func set_dance(dance: Dance):
	self.dance = dance
	%Tabs/Figures.set_dance(dance)
	%Tabs/Music.set_dance(dance)
	%Tabs/Posture.set_dance(dance)
	%Tabs/History.set_dance(dance)
