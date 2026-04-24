class_name Dance
extends Resource


@export var name: String
@export var history: History = History.new()
@export var music: Music = Music.new()
@export var posture: Posture = Posture.new()
@export var figures: Array[Figure]
@export var choreos: Array[Choreo]
