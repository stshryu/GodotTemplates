class_name MaxLife
extends ItemProperty

func _init():
	property_key = "maximum_life"
	property_name = "Maximum Life"
	modifier_type = ItemMetadata.ModifierEnum.PREFIX
	set_item_tier_bands()

### Handles the tiering required to roll the property on an item
func set_item_tier_bands():
	item_tier_bands = {
		10: [1, 10, 100],
		20: [11, 20, 50],
		30: [21, 40, 10]
	}

func add_to_item(item: BaseItem) -> ItemProperty:
	roll_property(item.item_level)
	return self
