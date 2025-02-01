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

func _ready():
	playerhealthbar.max_value = default_health
	_display_weapon_stats()

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
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

func _display_weapon_stats():
	var weapon = %Bow
	var ammo = %Bow.ammo
	var new_ammo = ammo.instantiate()
	for strategy in weapon.ammo_modifiers:
		strategy.apply_upgrade(new_ammo)
	var dmg = "Damage: %s\n"
	var travel = "Travel: %s\n"
	var speed = "Speed: %s\n"
	var pierce = "Pierce: %s\n"
	%PlayerStats.text = ""
	%PlayerStats.append_text(dmg % str(new_ammo.damage))
	%PlayerStats.append_text(travel % str(new_ammo.max_travel_dist))
	%PlayerStats.append_text(speed % str(new_ammo.proj_speed))
	%PlayerStats.append_text(pierce % str(new_ammo.pierce))
