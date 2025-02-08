class_name BaseSword
extends BaseWeapon
	
func _ready():
	ammo = preload("res://game/Ammo/SwordAmmo/SwordAmmo.tscn")
	projectiles += 0
	base_projectile_arc_degree = 90.0

func child_shoot_override(ammo: Ammo):
	ammo.global_rotation += deg_to_rad(-90)
	return ammo
	
func deferred_child_shoot_override(ammo: Ammo):
	ammo.sprite.rotation_degrees += 90
	
func _physics_process(delta):
	#manual_aim()
	auto_aim()
