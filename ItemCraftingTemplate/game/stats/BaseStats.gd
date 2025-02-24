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

func parse_equipment_stats(parsed_stats: Dictionary):
	for key in parsed_stats:
		if key == StatMetadata.StatEnum.MAXIMUM_LIFE:
			update_maximum_health(parsed_stats[key])
		elif key == StatMetadata.StatEnum.MOVEMENT_SPEED:
			update_movement_speed(parsed_stats[key])
		elif key == StatMetadata.StatEnum.MAXIMUM_MANA:
			update_maximum_mana(parsed_stats[key])

func get_custom_properties():
	var response = {}
	for property in self.get_property_list():
		if property["usage"] == 4102:
			response[property["name"]] = self.get(property["name"])
	return response
