extends Node


const PATH: String = "user://dance_notation.tres"

var dance_notation: DanceNotation


func load() -> DanceNotation:
	if ResourceLoader.exists(PATH):
		dance_notation = ResourceLoader.load(PATH)
	if not dance_notation:
		dance_notation = DanceNotation.new()
	return dance_notation


func save():
	ResourceSaver.save(dance_notation, PATH)
