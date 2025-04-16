extends Node2D

@onready var arrow_texture := %ArrowTexture

var placement_coord: Vector2i
var direction: Vector2i

func use_ability(params: Dictionary):
	print("Hi, straight_line_ability executing")
