class_name BaseEnemy
extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
@onready var mobhealthbar = %HealthBar

@export var mob_speed: float
@export var default_health: float
@export var damage_rate: float

var current_health

func _physics_process(delta):
	move_towards_player()

func move_towards_player():
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * mob_speed
	move_and_slide()

func take_damage(amount: float):
	current_health -= amount
	mobhealthbar.value = current_health
	if current_health <= 0.0:
		queue_free()
