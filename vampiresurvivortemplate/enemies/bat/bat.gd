extends BaseEnemy

func _ready():
	mob_speed = 100.0
	default_health = 50.0
	damage_rate = 100.0

	current_health = default_health
