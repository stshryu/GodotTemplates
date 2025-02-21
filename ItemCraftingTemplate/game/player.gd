class_name Player
extends CharacterBody2D

@onready var playerstats: BaseStats = BaseStats.new()

func _ready():
	pass
	
func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * playerstats.movement_speed
	move_and_slide()
