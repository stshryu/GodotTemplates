class_name ModifierParams
extends Resource

@export var AdditiveProperties: Dictionary
@export var MultiplicativeProperties: Dictionary
@export var GlobalProperties: Dictionary

enum ModifierKeys {
	ADD,
	MULT,
	GLOBAL,
}

func _init(base_properties: Dictionary):
	AdditiveProperties = base_properties["AddProperties"]
	MultiplicativeProperties = base_properties["MultiProperties"]
	GlobalProperties = base_properties["GlobalProperties"]
	
func add_property(key: ModifierKeys, property_key: String, value: Modifier):
	if key == ModifierKeys.ADD:
		if AdditiveProperties.has(key):
			AdditiveProperties[key].append(value)
		else:
			AdditiveProperties[key] = [value]
	elif key == ModifierKeys.MULT:
		if MultiplicativeProperties.has(key):
			MultiplicativeProperties[key].append(value)
		else:
			MultiplicativeProperties[key].append(value)
	elif key == ModifierKeys.GLOBAL:
		if GlobalProperties.has(key):
			GlobalProperties[key].append(value)
		else:
			GlobalProperties[key].append(value)
			
func get_property(key: ModifierKeys, property_key: String, tags: Array[Modifier.ModifierTags]):
	pass
