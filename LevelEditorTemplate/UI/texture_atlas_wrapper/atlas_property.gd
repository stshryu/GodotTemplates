class_name AtlasProperty
extends Resource

var position: Vector2
var size: Vector2
var scene: PackedScene

func _init(position_input: Vector2, size_input: Vector2, scene_input: PackedScene):
	position = position_input
	size = size_input
	scene = scene_input
