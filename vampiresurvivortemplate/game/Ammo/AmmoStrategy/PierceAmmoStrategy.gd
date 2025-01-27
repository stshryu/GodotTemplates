class_name PierceAmmoStrategy
extends BaseAmmoStrategy

func apply_upgrade(ammo: Ammo, modifier_params: Dictionary = {}):
	ammo.pierce += 5
