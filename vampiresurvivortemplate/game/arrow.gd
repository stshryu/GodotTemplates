extends Area2D

@export var arrow_speed = 300
@export var max_travel_dist = 1000

var traveled_distance = 0

func _physics_process(delta):
	var direction = Vector2(1,0).rotated(rotation)
	position += direction * arrow_speed * delta
	
	traveled_distance += arrow_speed * delta
	if traveled_distance > max_travel_dist:
		queue_free()

func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
