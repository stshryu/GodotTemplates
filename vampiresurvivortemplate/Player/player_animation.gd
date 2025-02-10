extends Node2D

@export var animation_tree: AnimationTree
@onready var player: Player = get_owner()

func _physics_process(delta: float) -> void:
	var idle = !player.velocity
	 
	if !idle:
		player.last_facing_direction = player.velocity.normalized()
		
	animation_tree.set("parameters/PlayerStates/Walk/blend_position", player.last_facing_direction)
	animation_tree.set("parameters/PlayerStates/Idle/blend_position", player.last_facing_direction)

	animation_tree.set("parameters/TimeScale/scale", 4)
