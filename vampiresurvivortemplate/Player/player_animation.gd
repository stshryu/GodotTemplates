extends Node2D

@export var animation_tree: AnimationTree
@onready var player: Player = get_owner()

func _physics_process(delta: float) -> void:
	var idle = !player.velocity
	
	if !idle:
		player.last_facing_direction = player.velocity.normalized()
		
	animation_tree.set("parameters/PlayerStates/Walk/blend_position", player.last_facing_direction)
	animation_tree.set("parameters/PlayerStates/Idle/blend_position", player.last_facing_direction)

	set_anim_speed(player)

func set_anim_speed(player: Player) -> void: 
	var playerms = player.playerstats.movement_speed
	var speed_mult = playerms / 25
	animation_tree.set("parameters/TimeScale/scale", speed_mult)
