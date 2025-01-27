class_name SpeedAmmoStrategy
extends BaseAmmoStrategy

func apply_upgrade(ammo: Ammo, modifier_params: Dictionary = {}):
	ammo.proj_speed += 500
