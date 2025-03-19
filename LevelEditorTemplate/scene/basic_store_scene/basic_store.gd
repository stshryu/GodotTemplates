class_name BasicStore
extends BaseScene

@export var tilemap: TileMapLayer

func _init():
	scene_map["tilemap"] = tilemap
	scene_map["size"] = Vector2i(50, 50)
	scene_map["contents"] = []
