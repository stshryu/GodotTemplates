class_name BaseBow
extends BaseWeapon

func _ready():
	ammo = preload("res://game/Ammo/BowAmmo/BowAmmo.tscn")
	projectiles += 3
	base_projectile_arc_degree = 180.0

func _physics_process(delta):
	manual_aim()
	#auto_aim()
