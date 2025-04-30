@tool
class_name HybridExports
extends Resource

"""
This file is going to use conditionals and dynamically add fields into our editor.

An exported boolean flag called flagName when switched on will display a category and group and string input value
that the user can edit, if the flag is on. If its off we'll hide the field to prevent editing.

Additionally, the check_if_true() function can do things based on whether or not the flag is on or off. In this case
when the flag is turned off, the value that WAS inside of it gets set to empty (we can always change that behavior whenever).

The goal here is to create conditional flags that lets us dynamically change parts of our resource.
"""

@export var flagName: bool:
	set(value):
		flagName = value
		check_if_true()
		
func check_if_true() -> void:
	if !flagName:
		c0g0someToggledValue = ""
	notify_property_list_changed()

var c0g0someToggledValue: String

func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	if flagName:
		properties.append({
			"name": "Toggled Category",
			"type": TYPE_NIL,
			"usage": PROPERTY_USAGE_CATEGORY,
			"hint_string": "c0" ## This is the first hint string that lets the editor know what the path for this property is
		})
		properties.append({
			"name": "Category Group",
			"type": TYPE_NIL,
			"usage": PROPERTY_USAGE_GROUP,
			"hint_string": "c0g0" ## This is the second hint string, that says any variable that starts with c0g0 will be a part of this category, and this group within the category
		})
		properties.append({
			"name": "c0g0someToggledValue",
			"type": TYPE_STRING,
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint_string": "c0g0someToggledValue" ## This is the second hint string, that says any variable that starts with c0g0 will be a part of this category, and this group within the category
		})
	return properties
