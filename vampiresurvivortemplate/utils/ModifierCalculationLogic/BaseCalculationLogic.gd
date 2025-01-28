class_name BaseCalculationLogic

"""
The base logic for how modifiers are calculated.

The order in which they are calculated can be changed by overriding this method.

By default, additive properties are all summed together, before being multiplied
by the sum of all the multiplicative properties.

Furthermore, each additive property has a tag, and each multiplicative property 
also has a tag. These are likewise added together before being summed up with the 
entire property type.

Keep in mind that a PropertyKey: Global is always also summed up and multiplied
alongside each individual keys values to get the final number.

PropertyKey: Damage 
ModifierTags: PROJECTILE
-- Example Damage Key --
AddProperty = [(1, [RANGED, PROJECTILE]), (5, [PROJECTILE]), (2, [PROJECTILE, MELEE])]
MultiProperty = [(4, [PROJECTILE, MELEE]), (3, [RANGED, MELEE])]

PropertyKey: Global
ModifierTags: PROJECTILE
-- Example Global Key -- 
AddProperty = []
MultiProperty = [(4, [PROJECTILE, MELEE])]

Returns -> Damage: [1 + 5 + 2](local) + [](global) * [4](local) + [4](global)
					8 * 8 = 64
"""

func calculate_modifier_param(modifier_params: ModifierParams, key: String):
	var add_values = modifier_params.get_add_property(key)
	var multi_values = modifier_params.get_multi_property(key)
	var _add = 0
	var _mult = 0
	for val in add_values:
		_add += val
	for val in multi_values:
		_mult += val
		
	return _add * _mult
