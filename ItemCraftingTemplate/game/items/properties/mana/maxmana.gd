class_name MaxMana
extends ItemProperty

func _init():
	property_key = StatMetadata.StatEnum.MAXIMUM_MANA
	property_name = "Maximum Mana"
	modifier_type = ItemMetadata.ModifierEnum.PREFIX
	set_item_tier_bands()

## Handles the tiering required to roll the property on an item
func set_item_tier_bands():
	item_tier_bands = {
		10: [1, 10, 100],
		20: [11, 20, 90],
		30: [21, 40, 80],
		40: [41, 100, 70]
	}

func add_to_item(item: BaseItem) -> ItemProperty:
	roll_property(item.item_level)
	return self
