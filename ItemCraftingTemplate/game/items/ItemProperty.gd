class_name ItemProperty
extends Resource

# Item Properties
var property_key: StatMetadata.StatEnum
var property_name: String
var property_value

# Item Metadata
var tags: Array[String]
var modifier_type: ItemMetadata.ModifierEnum
var crafting_weight: float

# Tier bands handle the range of mods a property can roll. This dictionary should hold a subset of 
# arrays that has 3 values: 
#
# key: int = [min_value: float, max_value: float, tier_weight: int]
#
# Where the key represents the MINIMUM level required for these mods to appear on an item.
var item_tier_bands: Dictionary

# Apply this property to the player
func apply_property(player: Player):
	pass 

# Create this property based on an item level (determines highest tier band that can be rolled).
func roll_property(item_level: int):
	var rng = RandomNumberGenerator.new()
	var values = []
	var weights = []
	for key in item_tier_bands.keys():
		if key <= item_level:
			values.append(key)
			weights.append(item_tier_bands[key][2])
	weights = PackedFloat32Array(weights)
	var key = values[rng.rand_weighted(weights)]
	property_value = rng.randi_range(item_tier_bands[key][0], item_tier_bands[key][1])

## Debugging the weights to ensure that the modifier types are matching our weights we defined.
func _debug_weights(item_level: int, debug_limit: int):
	var debug_bucket: Array = []
	for i in range(0, debug_limit):
		roll_property(item_level)
		debug_bucket.append(self.property_value)
	var debug_expected_output: Dictionary = {}
	var debug_actual_output: Dictionary = {}
	var max_weighted_val: int = 0
	for key in item_tier_bands.keys():
		max_weighted_val += item_tier_bands[key][2]
	for key in item_tier_bands.keys():
		debug_expected_output[key] = debug_limit * (float(item_tier_bands[key][2]) / float(max_weighted_val))
		var count = 0
		for i in debug_bucket:
			if item_tier_bands[key][0] < i and i <= item_tier_bands[key][1]:
				count += 1
		debug_actual_output[key] = count
	print("Expected Weightings")
	print(debug_expected_output)
	print("Actual Weightings")
	print(debug_actual_output)
