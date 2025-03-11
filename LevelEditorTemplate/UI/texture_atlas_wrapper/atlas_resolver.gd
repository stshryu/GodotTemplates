class_name AtlasResolver
extends Resource

@export var atlas: Texture2D

var atlas_properties: Dictionary[String, AtlasProperty]

func get_texture(key: String) -> AtlasTexture:
	if atlas_properties.has(key):
		var texture = AtlasTexture.new()
		texture.set_atlas(atlas)
		texture.region = Rect2(
			atlas_properties[key].position, atlas_properties[key].size
		)
		Logger.infomsg("AtlasResolver", "Texture found for %s" % key)
		return texture
	Logger.errormsg("AtlasResolver", "Texture not found for %s" % key)
	return null

func get_scene(key: String) -> PackedScene:
	if atlas_properties.has(key):
		if atlas_properties[key].has("scene"):
			Logger.infomsg("AtlasResolver", "Scene found for %s" % key)
			return atlas_properties[key].scene
	Logger.errormsg("AtlasResolver", "Scene not found for %s" % key)
	return null
