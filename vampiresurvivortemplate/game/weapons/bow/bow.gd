class_name BaseBow
extends BaseWeapon

func _ready():
	ammo = preload("res://game/Ammo/BowAmmo/BowAmmo.tscn")

func _physics_process(delta):
	manual_aim()
	#auto_aim()

func _on_timer_timeout():
	shoot()

func _on_player_upgrade_picked_up(player_upgrades: Array[BaseAmmoStrategy]):
	ammo_modifiers = player_upgrades
