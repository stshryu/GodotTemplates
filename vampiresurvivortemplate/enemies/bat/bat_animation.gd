extends Node2D

@export var animation_tree: AnimationTree
@onready var enemy: BaseEnemy = get_owner()

func _physics_process(delta: float) -> void:
	animation_tree.set("parameters/BatAnim/Move/blend_position", enemy.velocity.normalized())

	set_anim_speed(enemy)

func set_anim_speed(enemy: BaseEnemy) -> void: 
	var enemyms = enemy.mobstats.movement_speed
	var speed_mult = enemyms / 25
	animation_tree.set("parameters/TimeScale/scale", speed_mult)
