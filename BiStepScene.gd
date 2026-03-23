extends VBoxContainer


var step: BiStep = BiStep.new()


func _ready() -> void:
	$Lead.step = step.lead
	$Follow.step = step.follow
