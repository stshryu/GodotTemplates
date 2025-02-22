class_name BaseItem
extends Node2D

# Editor Item Properties
@export var item_name: String
@export var item_sprite: Texture2D

# Item Properties
var item_properties: Dictionary = {}
var item_quality: int
var item_level: int

func _init():
	item_properties[ItemMetadata.ModifierEnum.PREFIX] = []
	item_properties[ItemMetadata.ModifierEnum.SUFFIX] = []
	item_properties[ItemMetadata.ModifierEnum.BASE] = []
	item_properties[ItemMetadata.ModifierEnum.IMPLICIT] = []

### The item_properties, actually contains four keys: prefixes, suffixes, base, implicit.
### Each of those four properties can have any number of ItemProperty key value pairs within them
### set by the actual item itself. The items that inherit this custom resource are responsible
### for setting their own limits for the number of prefixes, suffixes, base and implicit values
### that can affect the item (and by extension the player).
