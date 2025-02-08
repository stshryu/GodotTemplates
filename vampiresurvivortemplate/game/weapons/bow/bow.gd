class_name BaseBow
extends BaseWeapon

func _ready():
	ammo = preload("res://game/Ammo/BowAmmo/BowAmmo.tscn")
	projectiles += 0
	base_projectile_arc_degree = 90.0

func _physics_process(delta):
	manual_aim()
	#auto_aim()
