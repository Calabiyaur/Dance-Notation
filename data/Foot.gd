class_name Foot
extends Resource


@export var direction: float = 0 # in radians
@export var length: float = 0 # 0 = no step, 1 = normal step


func _init(direction: float = 0, length: float = 0) -> void:
	self.direction = direction
	self.length = length
