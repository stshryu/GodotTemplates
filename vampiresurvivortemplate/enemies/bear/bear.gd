extends BaseEnemy

func _ready():
	mob_speed = 50.0
	default_health = 200.0
	damage_rate = 5.0
	mobhealthbar.max_value = default_health
	mobhealthbar.value = default_health
	current_health = default_health
