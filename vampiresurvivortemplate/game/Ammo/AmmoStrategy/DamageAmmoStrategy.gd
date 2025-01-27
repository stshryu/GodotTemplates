class_name DamageAmmoStrategy
extends BaseAmmoStrategy

func apply_upgrade(ammo: Ammo, modifier_params: Dictionary = {}):
	ammo.damage = ammo.damage * 2
		
