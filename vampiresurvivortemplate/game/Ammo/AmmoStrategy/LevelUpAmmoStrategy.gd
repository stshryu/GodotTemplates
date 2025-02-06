class_name LevelUpAmmoStrategy
extends BaseAmmoStrategy

@export var stat_increase: float

func apply_upgrade(ammo: Ammo):
	ammo.damage += stat_increase
	ammo.max_travel_dist += stat_increase
	ammo.proj_speed += stat_increase
