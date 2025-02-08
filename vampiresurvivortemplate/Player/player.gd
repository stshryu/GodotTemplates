class_name Player
extends CharacterBody2D

signal gameover
signal upgrade_picked_up
signal weapon_upgrade_picked_up

@onready var hurtbox = %HurtBox
@onready var playerhealthbar = %HealthBar
@onready var playerstats: PlayerStats = PlayerStats.new()

var player_upgrades: Array[BaseAmmoStrategy] = []
var player_weapon_upgrades: Array[BaseWeaponStrategy] = []
var player_level: LevelUpAmmoStrategy
var current_health: float

func _ready():
	player_level = LevelUpAmmoStrategy.new()
	player_level.stat_increase = 0
	player_upgrades.append(player_level)
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
	_display_weapon_stats()
	
func level_up():
	upgrade_picked_up.emit(player_upgrades)	
	
func _upgrade_picked_up(ammo_strategy: BaseAmmoStrategy):
	player_upgrades.append(ammo_strategy)
	upgrade_picked_up.emit(player_upgrades)
	_display_weapon_stats()
	
func _weapon_upgrade_picked_up(weapon_strategy: BaseWeaponStrategy):
	player_weapon_upgrades.append(weapon_strategy)
	weapon_upgrade_picked_up.emit(weapon_strategy)
	_display_weapon_stats()
	
"""
TODO: Finished creating a util script that does the debugging we want.
	
Should consider moving this block of code, and its associated nodes, the PlayerStats and the 
PlayerInternalStats RichTextLabels out into a separate canvas entity located on the game itself, not
on the player.

That way we can also do things like display debug stats for enemies as well easily without needing
to implement it for each mob we create.
"""
func _display_player_stats():
	var stats = EntityStats.get_customresource_property_list(playerstats)
	var basestr = "%s: %s\n"
	%PlayerInternalStats.text = ""
	for key in stats:
		%PlayerInternalStats.append_text(basestr % [key, stats[key]])
	
func _display_weapon_stats():
	var bow = %Bow
	var sword = %Sword
	var bowstats = WeaponDebug.calculate_and_display_weapon_modifiers(bow)
	var swordstats = WeaponDebug.calculate_and_display_weapon_modifiers(sword)
	var basestr = "%s: %s\n"
	%PlayerStats.text = ""
	%PlayerStats.text = "Bow:\n"
	for key in bowstats:
		%PlayerStats.append_text(basestr % [key, bowstats[key]])
	%PlayerStats.append_text("Sword:\n")
	for key in swordstats:
		%PlayerStats.append_text(basestr % [key, swordstats[key]])
