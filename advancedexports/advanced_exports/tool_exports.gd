@tool
class_name ToolExports
extends Node2D

"""
This file will represent an advanced setup with @tool to create a powerful editable resource in the inspector.

We'll look at all the stuff added in base_exports, but also add in conditional flags and expanded inspector options.

As you can see the top of the file has a @tool line that prefaces everything, this allows Godot to run this script in 
the editor, giving us the ability to update fields on the fly.

I personally don't like how this looks while editing the files. It might be handy to have a plugin/extention that handles creating
all the exporting metadata tags (like c0g0sg0) and naming conventions to make creating these fields easier.
"""

## This field MUST match what is in the property list (if we want it to store the value properly. That means if we named this 
## variable TestName instead of testName, we won't be able to update the value at all).
var testName: String 
var c0g0sg0randomName: String
var c0g0nonSubgroupName: String
var c0g0sg0testRange: float

## Based on the name, lets dynamically change this color.
var testColor: Color

func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	
	## Similar to how we handle @export_category in the base exports example, we're creating categories through the property field.
	properties.append({
		"name": "Test Category",
		"type": TYPE_NIL,
		"usage": PROPERTY_USAGE_CATEGORY ## Note the bitflag is different from the properties that follow below this one
	})
	properties.append({
		"name": "testName", ## Mirrors the value testName defined above in line 21.
		"type": TYPE_STRING,
		"usage": PROPERTY_USAGE_DEFAULT
	})
	properties.append({
		"name": "testColor",
		"type": TYPE_COLOR,
		"usage": PROPERTY_USAGE_DEFAULT
	})
	
	## A separate category
	properties.append({
		"name": "Another Category",
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
		"name": "Sub Group",
		"type": TYPE_NIL,
		"usage": PROPERTY_USAGE_SUBGROUP,
		"hint_string": "c0g0sg0" ## Translates to: Category 0, Group 0, SubGroup 0
	})
	properties.append({
		"name": "c0g0sg0randomName",
		"type": TYPE_STRING,
		"usage": PROPERTY_USAGE_DEFAULT,
		"hint_string": "c0g0sg0randomName" ## This is placed under Another Category->Category Group->Sub Group
	})
	properties.append({
		"name": "c0g0sg0testRange",
		"type": TYPE_FLOAT,
		"usage": PROPERTY_USAGE_DEFAULT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "-10.0,10.0,0.2",
	})
	properties.append({
		"name": "c0g0nonSubgroupName",
		"type": TYPE_STRING,
		"usage": PROPERTY_USAGE_DEFAULT,
		"hint_string": "c0g0nonSubgroupName" ## This is placed under Another Category->Category Group (note it isn't under the sub-group).
	})

	return properties
