class_name BaseWeapon
extends Area2D

var ammo: PackedScene
var ammo_modifiers: Array[BaseAmmoStrategy] = []

"""
Weapon specific upgrade modifiers
"""
@export var base_projectile_count = 1
var projectiles = base_projectile_count
var base_projectile_arc_degree: float

func _ready():
	pass
	
func manual_aim():
	rotation += get_local_mouse_position().angle()
	
func auto_aim():
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)

func shoot(override_rotation = null):
	var new_ammo = ammo.instantiate()
	new_ammo.global_position = %BulletSpawnPoint.global_position
	if override_rotation:
		var base_rotation_start = %BulletSpawnPoint.global_rotation - deg_to_rad(base_projectile_arc_degree / 2)
		new_ammo.global_rotation = base_rotation_start + deg_to_rad(override_rotation)
	else:
		new_ammo.global_rotation = %BulletSpawnPoint.global_rotation
	for strategy in ammo_modifiers:
		strategy.apply_upgrade(new_ammo)
	child_shoot_override(new_ammo)
	%BulletSpawnPoint.add_child(new_ammo)
	deferred_child_shoot_override(new_ammo)

# Allow children to manipulate the shoot method.
func child_shoot_override(ammo: Ammo) -> Ammo:
	return ammo
	
# The deferred method will manipulate an already created (and processed into the scene tree) object 
# of the ammo, there's no need to return the ammo since we will be manipulating it directly through 
# the tree.
func deferred_child_shoot_override(ammo: Ammo):
	pass

func calculate_multiple_projectile_rotation(projectile_count: int) -> Array[float]:
	var rotation_array: Array[float] = []
	var subdegrees = base_projectile_arc_degree / (projectile_count + 1)
	for i in range(1, projectile_count + 1):
		rotation_array.append(i * subdegrees)
	return rotation_array
	
func _physics_process(delta):
	manual_aim()
	#auto_aim()

func _on_timer_timeout():
	if projectiles > 1:
		var rotation_array = calculate_multiple_projectile_rotation(projectiles)
		for i in rotation_array:
			shoot(i)
	else:
		shoot()

func _on_player_upgrade_picked_up(player_ammo_upgrades: Array[BaseAmmoStrategy]):
	ammo_modifiers = player_ammo_upgrades
	
func _on_player_weapon_upgrade_picked_up(player_weapon_upgrades: BaseWeaponStrategy):
	player_weapon_upgrades.apply_upgrade(self)
