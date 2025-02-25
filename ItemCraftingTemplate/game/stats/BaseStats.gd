class_name BaseStats
extends Resource

@export var movement_speed: float
@export var maximum_life: float
@export var maximum_mana: float
@export var current_life: float

func _init():
	movement_speed = 200.0
	maximum_life = 100.0
	maximum_mana = 100.0
	current_life = maximum_life

func get_movement_speed(parsed_stats: Dictionary) -> float:
	if parsed_stats.has(StatMetadata.StatEnum.MOVEMENT_SPEED):
		return movement_speed + parsed_stats[StatMetadata.StatEnum.MOVEMENT_SPEED]
	return movement_speed

func update_movement_speed(amount: float):
	movement_speed += amount
	if movement_speed < 0: movement_speed = 0
	
func update_maximum_health(amount: float):
	maximum_life += amount
	if maximum_life < 0: maximum_life = 0
	
func update_maximum_mana(amount: float):
	maximum_mana += amount
	if maximum_mana < 0: maximum_mana = 0
	
func heal_damage(amount: float):
	current_life += amount
	if current_life > maximum_life: current_life = maximum_life
	
func take_damage(amount: float):
	current_life -= amount
	if current_life < 0: current_life = 0

func get_combined_stats(parsed_stats: Dictionary) -> Dictionary:
	var response = get_custom_properties()
	for key in parsed_stats:
		var converted_key = StatMetadata.covert_enum_to_key(key)
		if response.has(converted_key):
			response[converted_key] += parsed_stats[key]
		else:
			response[converted_key] = parsed_stats[key]
	return response

func get_custom_properties():
	var response = {}
	for property in self.get_property_list():
		if property["usage"] == 4102:
			response[property["name"]] = self.get(property["name"])
	return response
