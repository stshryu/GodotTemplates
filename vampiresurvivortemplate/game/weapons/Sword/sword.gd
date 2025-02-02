class_name BaseSword
extends Area2D

const ammo = preload("res://game/Ammo/SwordAmmo/SwordAmmo.tscn")

var ammo_modifiers: Array[BaseAmmoStrategy] = []
	
func manual_aim():
	rotation += get_local_mouse_position().angle()
	
func auto_aim():
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)

func shoot():
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
	
func _print_weapon_stats():
	var new_ammo = ammo.instantiate()
	for strategy in ammo_modifiers:
		strategy.apply_upgrade(new_ammo)
	new_ammo._ready()
	return new_ammo.to_string()
