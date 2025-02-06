extends Node

func calculate_and_display_weapon_modifiers(weapon):
	var response = {}
	var ammo = weapon.ammo
	var testammo = ammo.instantiate()
	for strategy in weapon.ammo_modifiers:
		strategy.apply_upgrade(testammo)
		if strategy.get("multiplier"):
			print('hi')
			if strategy.multiplier > 2.0:
				print('hi')
	testammo._ready()
	for property in testammo.get_property_list():
		if property["usage"] == 4102: # Custom properties we define seem to always show up as 4102
			response[property["name"]] = testammo.get(property["name"])
	return response
