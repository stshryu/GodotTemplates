extends CharacterBody2D

signal gameover

@export var player_speed = 100
@export var default_health = 100.0

@onready var current_health = default_health
@onready var hurtbox = %HurtBox
@onready var playerhealthbar = %HealthBar

func _ready():
	playerhealthbar.max_value = default_health

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
	
