class_name BaseScene
extends Node2D

"""
Scenes need a coordinate plane that denotes the boundaries of the scene, and the contents within.
The scene_map will hold the base texture, the size, and contents of the scene. The contents array
should hold a SceneContent resource that has the position, and the related atlas_property node
that holds the actual texture, size, and scene (if the atlas_property has a scene).
"""
var scene_map: Dictionary = {
	"base_map": TileMapLayer,
	"size": Vector2.ZERO,
	"contents": [SceneContent],
}

func save_editor_scene():
	pass
	
func load_scene_into_editor():
	pass
