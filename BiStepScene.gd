extends VBoxContainer


var step: BiStep = BiStep.new()


func _ready() -> void:
	$Lead.step = step.lead
	$Follow.step = step.follow


func get_lead():
	return $Lead


func get_follow():
	return $Follow
