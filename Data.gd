extends Node


const PATH: String = "user://dance_notation.tres"

var dance_notation: DanceNotation


func load() -> DanceNotation:
	dance_notation = load(PATH)
	return dance_notation


func save():
	ResourceSaver.save(dance_notation, PATH)
