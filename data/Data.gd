class_name Data
extends Resource


const PATH: String = "user://data.tres"

static var instance: Data

@export var dances: Array[Dance]


static func load() -> Data:
	if ResourceLoader.exists(PATH):
		instance = ResourceLoader.load(PATH)
	if not instance:
		instance = Data.new()
	return instance


static func save():
	ResourceSaver.save(instance, PATH)


static func print():
	var file = FileAccess.open(PATH, FileAccess.READ)
	print(file.get_as_text())
