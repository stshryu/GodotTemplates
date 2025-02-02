class_name BaseEnemy
extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
@onready var mobhealthbar = %HealthBar
@onready var expdrop = preload("res://game/items/expitem/expdrop.tscn")

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
		drop_loot()
		queue_free()

func drop_loot(): # Implement an actual loot table, for now lets only have the mobs drop exp when killed
	var newdrop = expdrop.instantiate()
	newdrop.position = position
	get_parent().add_child(newdrop)
