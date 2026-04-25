class_name Hand
extends Resource


@export var connected: bool = true
@export var direction: float = 0 # in radians
@export var height: float = 0 # 0 = normal, 1 = up, -1 = down
@export var length: float = 0 # 0 = no step, 1 = normal step


func _init(direction: float = 0, length: float = 0) -> void:
	self.direction = direction
	self.length = length
