class_name Player
extends BaseEntity

signal gameover
signal upgrade_picked_up
signal weapon_upgrade_picked_up

@onready var hurtbox = %HurtBox
@onready var playerhealthbar = %HealthBar
@onready var playerstats: PlayerStats = PlayerStats.new()
@onready var player_ability_node = %ability_ui_control
@onready var animation_tree = %AnimationTree
@onready var test_teleport_anim: AnimatedSprite2D = $teleport_end_effect

var player_upgrades: Array[BaseAmmoStrategy] = []
var player_weapon_upgrades: Array[BaseWeaponStrategy] = []
var player_level: LevelUpAmmoStrategy
var current_health: float

### Player entity related properties
var last_facing_direction := Vector2(0,-1)
var last_direction := Vector2.ZERO

### Player control related properties
var can_act: bool = true
var can_move: bool = true
var is_moving: bool = false
var is_casting: bool = false
var can_be_damaged: bool = true

func _ready():
	player_level = LevelUpAmmoStrategy.new()
	player_level.stat_increase = 0
	player_upgrades.append(player_level)
	var dash = player_ability_node.get_child(0)
	dash.set_parent(self)
	var teleport = player_ability_node.get_child(1)
	teleport.set_parent(self)
	_display_player_stats()
	_display_weapon_stats()

func _physics_process(delta):
	is_moving = true if velocity else false
	
	if can_act:
		var direction = Input.get_vector("left", "right", "up", "down")
		last_direction = direction
	velocity = last_direction * playerstats.movement_speed
	
	if can_move: 
		move_and_slide()
	
	### TODO:
	### Want to add a input mapping system where instead of pressing "dash" they'll be pressing 
	### ability slot 0, or ability slot 1 or something.
	if Input.is_action_just_pressed("dash"):
		var dash = player_ability_node.get_child(0)
		dash.use_ability()
	
	if Input.is_action_just_pressed("teleport"):
		var teleport = player_ability_node.get_child(1)
		teleport.use_ability()
	
	if can_be_damaged:
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

func _on_teleport_end_effect_animation_finished():
	test_teleport_anim.visible = false
