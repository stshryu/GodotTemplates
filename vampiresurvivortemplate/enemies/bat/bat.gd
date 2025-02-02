extends BaseEnemy

func _ready():
	mob_speed = 100.0
	default_health = 55.0
	damage_rate = 100.0
	mobhealthbar.max_value = default_health
	mobhealthbar.value = default_health
	current_health = default_health
