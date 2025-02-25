extends Node

func get_formatted_stats(stats: BaseStats, equipment: BaseEquipment) -> String:
	var parsed_stats = equipment.calculate_all_equipment_slots()
	var resp = []
	resp.append("[center]Stats\n---------\n")
	var stat_properties = stats.get_combined_stats(parsed_stats)
	var basestr = "%s: %s\n"
	for key in stat_properties:
		resp.append(basestr % [key, stat_properties[key]])
	resp.append("[center]")
	return "".join(resp)
