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
	tilemap_ruleset.tile_set = ruleset
	return tilemap_ruleset
