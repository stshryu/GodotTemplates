class_name PlayerStats
extends BaseStats

@export var experience: int
@export var current_level: int

func _init(): # Default Player Stats
	maximum_health = 100.0
	movement_speed = 100.0
	current_health = maximum_health
	experience = 0

func update_experience(amount: int, player: Player): # Consider moving the player object into the _init() call and connecting a signal instead
	experience += amount
	if experience < 0: experience = 0
	var new_level = calculate_level()
	if current_level < new_level:
		for i in range(0, (new_level-current_level)):
			player.player_level.stat_increase += 2
		current_level = new_level
		player.level_up()
	
func calculate_level() -> int:
	var calculated_level = int(experience / 1000)
	return calculated_level
