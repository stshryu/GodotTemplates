class_name Player
extends CharacterBody2D

signal gameover
signal upgrade_picked_up

@onready var hurtbox = %HurtBox
@onready var playerhealthbar = %HealthBar
@onready var playerstats: PlayerStats = PlayerStats.new()

var player_upgrades: Array[BaseAmmoStrategy] = []
var current_health: float

func _ready():
	_display_player_stats()
	_display_weapon_stats()

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * playerstats.movement_speed
	move_and_slide()
	
	var overlapping_mobs = hurtbox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		for mob in overlapping_mobs:
			if mob.get("mobstats"):
				playerstats.take_damage(mob.mobstats.damage * delta)
		playerhealthbar.value = playerstats.current_health
		if playerstats.current_health <= 0.0:
			gameover.emit()
	_display_player_stats()

func _upgrade_picked_up(ammo_strategy: BaseAmmoStrategy):
	player_upgrades.append(ammo_strategy)
	upgrade_picked_up.emit(player_upgrades)
	_display_weapon_stats()
	
func _display_player_stats():
	var basestr = "%s: %s\n"
	%PlayerInternalStats.text = ""
	%PlayerInternalStats.append_text(basestr % ["ms", playerstats.movement_speed])
	%PlayerInternalStats.append_text(basestr % ["max_h", playerstats.maximum_health])
	%PlayerInternalStats.append_text(basestr % ["current_health", playerstats.current_health])
	%PlayerInternalStats.append_text(basestr % ["exp", playerstats.experience])
	
func _display_weapon_stats(): 
	var weapon = %Bow
	var ammo = %Bow.ammo
	var new_ammo = ammo.instantiate()
	for strategy in weapon.ammo_modifiers:
		strategy.apply_upgrade(new_ammo)
	var sword = %Sword
	var swordammo = %Sword.ammo
	var newswordammo = swordammo.instantiate()
	for strategy in sword.ammo_modifiers:
		strategy.apply_upgrade(newswordammo)
	var dmg = "Damage: %s\n"
	var travel = "Travel: %s\n"
	var speed = "Speed: %s\n"
	var pierce = "Pierce: %s\n"
	new_ammo._ready()
	newswordammo._ready()
	%PlayerStats.text = ""
	%PlayerStats.append_text("Bow:\n")
	%PlayerStats.append_text(dmg % str(new_ammo.damage))
	%PlayerStats.append_text(travel % str(new_ammo.max_travel_dist))
	%PlayerStats.append_text(speed % str(new_ammo.proj_speed))
	%PlayerStats.append_text(pierce % str(new_ammo.pierce))
	%PlayerStats.append_text("Sword:\n")
	%PlayerStats.append_text(dmg % str(newswordammo.damage))
	%PlayerStats.append_text(travel % str(newswordammo.max_travel_dist))
	%PlayerStats.append_text(speed % str(newswordammo.proj_speed))
	%PlayerStats.append_text(pierce % str(newswordammo.pierce))
	
