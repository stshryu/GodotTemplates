extends Node2D

@onready var spawn_path = %PathFollow2D
@onready var mob_dir = DirAccess.open("res://enemies/")

var enemylist = []

func _ready():
	get_window().content_scale_factor = 2
	find_all_enabled_enemies()
	
func find_all_enabled_enemies():
	if mob_dir:
		mob_dir.list_dir_begin()
		var filename = mob_dir.get_next()
		while filename != "":
			if not mob_dir.current_is_dir():
				if filename.get_extension() == "tscn":
					var fullpath = "res://enemies/".path_join(filename)
					enemylist.append(load(fullpath))
			filename = mob_dir.get_next()
	
func random_mob_index_generator():
	var rng = RandomNumberGenerator.new()
	return rng.randi_range(0, enemylist.size() - 1)

func spawn_mob():
	var new_mob = enemylist[random_mob_index_generator()].instantiate()
	spawn_path.progress_ratio = randf()
	new_mob.global_position = spawn_path.global_position
	add_child(new_mob)

func _on_timer_timeout():
	spawn_mob()
