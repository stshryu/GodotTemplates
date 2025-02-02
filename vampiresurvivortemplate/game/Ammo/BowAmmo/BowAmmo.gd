class_name BowAmmo
extends Ammo

func _ready():
	proj_speed += 500
	max_travel_dist += 1000
	damage += 50
	pierce += 0
	
func _physics_process(delta):
	var direction = Vector2(1,0).rotated(rotation)
	position += direction * proj_speed * delta
	
	traveled_distance += proj_speed * delta
	if traveled_distance > max_travel_dist:
		queue_free()

func _on_body_entered(body):
	if pierce <= 0:
		queue_free()
	pierce -= 1
	if body.has_method("take_damage"):
		body.take_damage(damage)
