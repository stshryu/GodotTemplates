class_name BaseEquipment
extends Resource

var equipment = {}

func equip_item(slot: EquipmentMetadata.EquipmentSlot, item: BaseItem):
	if item.equipment_slot != slot:
		Logger.error("item_ui_boots", "Slot mismatch, unable to equip item.")
	else:
		equipment[slot] = item
		Logger.info("item_ui_boots", "Equipped %s to slot" % item.item_name)
	
func calculate_all_equipment_slots() -> Dictionary:
	var total_stats = {}
	for slot in equipment:
		var slot_stats = calculate_equipment_slot(slot)
		for key in slot_stats:
			if total_stats.has(key):
				total_stats[key] += slot_stats[key]
			else:
				total_stats[key] = slot_stats[key]
	return total_stats
	
func calculate_equipment_slot(slot: EquipmentMetadata.EquipmentSlot) -> Dictionary:
	var item: BaseItem = equipment[slot]
	var item_properties = item.get_all_properties()
	var parsed_properties = {}
	for key in item_properties:
		for prop in item_properties[key]:
			if parsed_properties.has(prop.property_key):
				parsed_properties[prop.property_key] += prop.property_value
			else:
				parsed_properties[prop.property_key] = prop.property_value
	return parsed_properties
