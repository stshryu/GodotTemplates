extends Area2D

const ammo = preload("res://game/Ammo/ammo.tscn")

func _physics_process(delta):
	manual_aim()
	#auto_aim()

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
	new_ammo.global_rotation = %BulletSpawnPoint.global_rotation
	var damage_strat = DamageAmmoStrategy.new()
	damage_strat.apply_upgrade(new_ammo)
	var pierce_strat = PierceAmmoStrategy.new()
	pierce_strat.apply_upgrade(new_ammo)
	%BulletSpawnPoint.add_child(new_ammo)

func _on_timer_timeout():
	shoot()
