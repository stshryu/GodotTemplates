extends Area2D

const ARROW = preload("res://game/arrow.tscn")

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)

func shoot():
	var new_arrow = ARROW.instantiate()
	new_arrow.global_position = %BulletSpawnPoint.global_position
	new_arrow.global_rotation = %BulletSpawnPoint.global_rotation
	%BulletSpawnPoint.add_child(new_arrow)

func _on_timer_timeout():
	shoot()
