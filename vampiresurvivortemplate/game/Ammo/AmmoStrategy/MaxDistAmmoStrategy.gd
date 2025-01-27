class_name MaxDistAmmoStrategy
extends BaseAmmoStrategy

func apply_upgrade(ammo: Ammo, modifier_params: Dictionary = {}):
	ammo.max_travel_dist += 500
	
