class_name BaseSword
extends BaseWeapon
	
func _ready():
	ammo = preload("res://game/Ammo/SwordAmmo/SwordAmmo.tscn")

func shoot(): # Unsure if this should be moved to the base class and call a method that modifies the bullet so child classes can modify how it behaves instead of re-writing the entire shoot function
	var new_ammo = ammo.instantiate()
	new_ammo.global_position = %BulletSpawnPoint.global_position
	new_ammo.global_rotation = %BulletSpawnPoint.global_rotation + deg_to_rad(-90)
	for strategy in ammo_modifiers:
		strategy.apply_upgrade(new_ammo)
	%BulletSpawnPoint.add_child(new_ammo)
	new_ammo.sprite.rotation_degrees += 90

func _physics_process(delta):
	#manual_aim()
	auto_aim()

func _on_timer_timeout():
	shoot()

func _on_player_upgrade_picked_up(player_upgrades: Array[BaseAmmoStrategy]):
	ammo_modifiers = player_upgrades
	
