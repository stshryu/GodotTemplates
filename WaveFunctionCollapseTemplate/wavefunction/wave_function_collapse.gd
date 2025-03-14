class_name WaveFunctionCollapse
extends Node

var ruleset: TileSet = preload("res://ruleset.tres")

func get_tile_size():
	Logger.infomsg(ruleset.tile_size)
