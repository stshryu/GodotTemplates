class_name BaseBow
extends Area2D

const ammo = preload("res://game/Ammo/ammo.tscn")

var ammo_modifiers: Array[BaseAmmoStrategy] = []
var default_modifiers: Dictionary = {
	"AddProperties": {},
	"MultiProperties": {}
}
var bow_modifiers: ModifierParams

func _ready():
	init_modifier_systems()
	load_weapon_modifiers()

func init_modifier_systems():
	ammo_modifiers = [
		DamageAmmoStrategy.new(),
		MaxDistAmmoStrategy.new(),
		PierceAmmoStrategy.new(),
		SpeedAmmoStrategy.new()
	]

func load_weapon_modifiers():
	bow_modifiers = ModifierParams.new(default_modifiers)
	
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
	for strategy in ammo_modifiers:
		strategy.apply_upgrade(new_ammo, bow_modifiers)
	%BulletSpawnPoint.add_child(new_ammo)

func _physics_process(delta):
	manual_aim()
	#auto_aim()

func _on_timer_timeout():
	shoot()
