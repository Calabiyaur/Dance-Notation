class_name Hand
extends Resource


@export var target: bool #TODO: Enum: free, partner's hand, other hand, shoulder, back
@export var direction: float = 0 # in radians
@export var height: float = 0 # 0 = normal, 1 = up, -1 = down
@export var length: float = 0 # 0 = not extended, 1 = fully extended
