class_name BaseStats
extends Resource

@export var movement_speed: float
@export var maximum_health: float
@export var current_health: float

func update_movement_speed(amount: float):
	movement_speed += amount
	if movement_speed < 0: movement_speed = 0
	
func update_maximum_health(amount: float):
	maximum_health += amount
	if maximum_health < 0: maximum_health = 0
	
func heal_damage(amount: float):
	current_health += amount
	
func take_damage(amount: float):
	current_health -= amount
	if current_health < 0: current_health = 0
