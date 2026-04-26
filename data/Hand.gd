class_name Hand
extends Resource


@export var target: bool = true #TODO: Enum: free, partner's hand, other hand, shoulder, back
@export var height: float = 0 # 0 = no change, 1 = up, -1 = down
@export var direction: float = 0 # in radians, disregarding height
@export var length: float = 0 # 0 = no change, 1 = fully extended
