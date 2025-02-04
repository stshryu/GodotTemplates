extends BaseEnemy

func _ready():
	mobstats.movement_speed = 50.0
	mobstats.maximum_health = 200.0
	mobstats.current_health = mobstats.maximum_health
	mobstats.update_damage(5.0)
	
	# Set Health values for visual healthbar
	mobhealthbar.max_value = mobstats.maximum_health
	mobhealthbar.value = mobstats.maximum_health
	
