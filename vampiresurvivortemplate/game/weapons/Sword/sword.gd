class_name BaseSword
extends BaseWeapon
	
func _ready():
	ammo = preload("res://game/Ammo/SwordAmmo/SwordAmmo.tscn")
	projectiles += 3
	base_projectile_arc_degree = 360.0

# This definetly needs to be moved out of the child class and into the parent class, and instead the child class
# should have some method that applies special effects to shoot(). 
# As it is now we can't apply projectiles overrides to this without copy-pasting the code again -_-
func shoot(override_rotation = null): 
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
