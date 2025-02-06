extends Node

func get_customresource_property_list(resource) -> Dictionary:
	var response = {}
	for property in resource.get_property_list():
		if property["usage"] == 4102: # Custom properties we define seem to always show up as 4102
			response[property["name"]] = resource.get(property["name"])
	return response
