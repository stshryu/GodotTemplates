class_name BaseStats
extends Resource

@export var movement_speed: float
@export var maximum_health: float
@export var current_health: float

func _init():
	movement_speed = 200.0
	maximum_health = 100.0
	current_health = maximum_health

func update_movement_speed(amount: float):
	movement_speed += amount
	if movement_speed < 0: movement_speed = 0
	
func update_maximum_health(amount: float):
	maximum_health += amount
	if maximum_health < 0: maximum_health = 0
	
func heal_damage(amount: float):
	current_health += amount
	if current_health > maximum_health: current_health = maximum_health
	
func take_damage(amount: float):
	current_health -= amount
	if current_health < 0: current_health = 0

func get_custom_properties():
	var response = {}
	for property in self.get_property_list():
		if property["usage"] == 4102:
			response[property["name"]] = self.get(property["name"])
	return response
