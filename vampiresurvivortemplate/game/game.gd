extends Node2D

@onready var spawn_path = %PathFollow2D

func spawn_mob():
	var new_mob = preload("res://enemies/bear/bear.tscn").instantiate()
	spawn_path.progress_ratio = randf()
	new_mob.global_position = spawn_path.global_position
	add_child(new_mob)

func _on_timer_timeout():
	spawn_mob()
