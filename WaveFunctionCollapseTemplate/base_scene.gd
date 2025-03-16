extends Node2D

@onready var gen_scene := %SceneGenControl

func display_generated_scene(tilemaplayer: TileMapLayer) -> void:
	tilemaplayer.set_cell(Vector2(0,0), 0, Vector2(0,0))
	gen_scene.add_child(tilemaplayer)
