class_name Player
extends CharacterBody2D

signal gameover
signal upgrade_picked_up

@export var player_speed = 100
@export var default_health = 100.0

@onready var current_health = default_health
@onready var hurtbox = %HurtBox
@onready var playerhealthbar = %HealthBar

var player_upgrades: Array[BaseAmmoStrategy] = []
var player_stats: Dictionary = {}

func _ready():
	playerhealthbar.max_value = default_health
	_set_player_base_stats()
	_display_weapon_stats()
	_display_player_stats()

func _set_player_base_stats():
	player_stats = {
		"exp": 0
	}

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * player_speed
	move_and_slide()
	
	var overlapping_mobs = hurtbox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		for mob in overlapping_mobs:
			if "damage_rate" in mob:
				current_health -= mob.damage_rate * delta
		playerhealthbar.value = current_health
		if current_health <= 0.0:
			gameover.emit()

func _upgrade_picked_up(ammo_strategy: BaseAmmoStrategy):
	player_upgrades.append(ammo_strategy)
	upgrade_picked_up.emit(player_upgrades)
	_display_weapon_stats()
	
func apply_item_to_player(operation: String, key: String, value):
	if operation == "add":
		player_stats[key] += value
	else:
		player_stats[key] -= value
	_display_player_stats()

func _display_player_stats(): # Move this (and weapon stats) into the debug scripts eventually
	var base_string = "%s: %s\n"
	%PlayerInternalStats.text = ""
	for key in player_stats:
		%PlayerInternalStats.append_text(base_string % [key, str(player_stats[key])])
	
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
	
