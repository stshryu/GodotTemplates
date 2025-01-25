extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")

@export var mob_speed = 50
@export var default_health = 100.0
var current_health = default_health

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * mob_speed
	move_and_slide()

func take_damage():
	current_health -= 50
	if current_health <= 0.0:
		queue_free()
