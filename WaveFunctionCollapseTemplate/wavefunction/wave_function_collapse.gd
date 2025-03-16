class_name WaveFunctionCollapse
extends Node

var ruleset: TileSet
var tilemap_ruleset: TileMapLayer
var tileset_array: Array

func _init() -> void:
	ruleset = preload("res://ruleset.tres")
	tilemap_ruleset = TileMapLayer.new()
	tilemap_ruleset.tile_set = ruleset

func load_ruleset() -> TileMapLayer:
	var tilesetsource = ruleset.get_source(0)
	var tilearray = tilesetsource.get_tiles_count()
	for i in tilearray:
		Logger.infomsg(tilesetsource.get_tile_data(tilesetsource.get_tile_id(i), 0).get_custom_data_by_layer_id(0))
	tilemap_ruleset.tile_set = ruleset
	return tilemap_ruleset
