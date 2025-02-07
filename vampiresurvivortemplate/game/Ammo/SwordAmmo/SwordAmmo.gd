class_name SwordAmmo
extends Ammo

@onready var hitbox: Area2D = %HitboxArea
@onready var sprite: Sprite2D = %SwordSprite

var rotating: bool = false
var minimum_proj_speed: int = 25
var base_proj_speed = 200

func _ready():
	proj_speed += 200
	max_travel_dist += 400
	damage += 200
	pierce += 0
	
func _physics_process(delta):
	var direction = Vector2(1,0).rotated(rotation)
	position += direction * proj_speed * delta
	if rotating:
		sprite.rotation_degrees += 10

	traveled_distance += proj_speed * delta
	if traveled_distance > max_travel_dist:
		queue_free()
	_calculate_damage_rate(delta)

func _calculate_damage_rate(delta):
	var overlapping_mobs = hitbox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		for mob in overlapping_mobs:
			if mob.has_method("take_damage"):
				mob.take_damage(damage * delta)

func _slow_proj_on_body_hit():
	proj_speed = proj_speed / 2 # Lets implement this eventually to be some function of proj speed so leveling up increases the slowdown on the sword
	if proj_speed < minimum_proj_speed: proj_speed = 25

func _on_body_entered(body):
	rotating = true
	_slow_proj_on_body_hit()
	
