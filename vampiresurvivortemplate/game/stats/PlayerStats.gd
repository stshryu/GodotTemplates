class_name PlayerStats
extends BaseStats

@export var experience: int

func _init(): # Default Player Stats
	maximum_health = 100.0
	movement_speed = 100.0
	current_health = maximum_health
	experience = 0

func update_experience(amount: int):
	experience += amount
	if experience < 0: experience = 0
