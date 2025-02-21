class_name BaseItem
extends Resource

# Editor Item Properties
@export var item_name: String
@export var item_sprite: Texture2D

# Item Properties
var item_properties: Dictionary
var item_quality: int
var item_level: int

### The item_properties, actually contains four keys: prefixes, suffixes, base, implicit.
### Each of those four properties can have any number of ItemProperty key value pairs within them
### set by the actual item itself. The items that inherit this custom resource are responsible
### for setting their own limits for the number of prefixes, suffixes, base and implicit values
### that can affect the item (and by extension the player).
