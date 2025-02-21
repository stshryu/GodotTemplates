class_name ItemProperty
extends Resource

# Item Properties
var property_key: String
var property_name: String
var property_value

# Item Metadata
var tags: Array[String]
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
