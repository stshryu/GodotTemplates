extends Node2D

@onready var gen_scene := %SceneGenControl

func display_generated_scene(tilemaplayer: TileMapLayer) -> void:
	Logger.infomsg("Generating Scene")
