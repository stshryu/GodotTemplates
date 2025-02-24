class_name BaseEquipment
extends Resource

var equipment = {}

func equip_item(slot: EquipmentMetadata.EquipmentSlot, item: BaseItem):
	if item.equipment_slot != slot:
		Logger.error("item_ui_boots", "Slot mismatch, unable to equip item.")
	else:
		equipment[slot] = item
		Logger.info("item_ui_boots", "Equipped %s to slot" % item.item_name)
	
