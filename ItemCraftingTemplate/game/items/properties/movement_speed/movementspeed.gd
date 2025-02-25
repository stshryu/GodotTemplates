class_name MovementSpeed
extends ItemProperty

func _init():
	property_key = StatMetadata.StatEnum.MOVEMENT_SPEED
	property_name = "Movement Speed"
	modifier_type = ItemMetadata.ModifierEnum.SUFFIX
	set_item_tier_bands()

## Handles the tiering required to roll the property on an item
func set_item_tier_bands():
	item_tier_bands = {
		10: [50, 50, 50],
		20: [100, 100, 40],
		30: [150, 150, 30],
		40: [200, 200, 20]
	}

func add_to_item(item: BaseItem) -> ItemProperty:
	roll_property(item.item_level)
	return self
