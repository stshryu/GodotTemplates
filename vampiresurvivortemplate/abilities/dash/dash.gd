class_name DashAbility
extends BaseAbility

@export var base_dash_distance: Vector2 = Vector2(40.0, 40.0)
	
func _ready():
	ability_name = "Dash"
	base_cooldown = 5.0
	timer.wait_time = base_cooldown

### TODO:
### Dash works weirdly when moving in a combined direction (NE, SE, NW, SW) 
func use_ability(entity):
	if is_usable:
		var current_position = entity.global_position
		var facing_direction = entity.last_facing_direction
		var new_dash_position = current_position + (base_dash_distance * facing_direction)
		entity.global_position = new_dash_position
		start_cooldown()
	else:
		print('on cd')
