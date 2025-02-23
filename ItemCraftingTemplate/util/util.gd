extends Node

func get_formatted_stats(stats: BaseStats) -> String:
	var resp = []
	resp.append("[center]Stats\n---------\n")
	var stat_properties = stats.get_custom_properties()
	var basestr = "%s: %s\n"
	for key in stat_properties:
		resp.append(basestr % [key, stats[key]])
	resp.append("[center]")
	return "".join(resp)
 
