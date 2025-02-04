class_name EnemyStats
extends BaseStats

@export var damage: float

func _init(): # Default Enemy Stats
	maximum_health = 100.0
	movement_speed = 100.0
	current_health = maximum_health
	damage = 10.0

func update_damage(amount: float):
	damage += amount
	if damage < 0: damage = 0
