class_name SceneManager
extends Node2D

@onready var current_scene = %CurrentScene

var next_scene: String
var _load_progress_timer: Timer

signal scene_finished_loading

var scenes := {
	"main_menu": "res://interface/main_menu.tscn",
	"other_scene": "res://interface/other_scene.tscn"
}

func _ready():
	# Move current scene to center
	current_scene.position = get_viewport_rect().size / 2.0
	
	# Setup signals
	scene_finished_loading.connect(next_scene_loaded)
	
	# Initial Scene
	load_scene("main_menu")
	
func get_path_from_key(key: String) -> String:
	if scenes.has(key):
		return scenes[key]
	else:
		return ""
		
func load_scene(scene_key: String) -> void:
	var scene_path = get_path_from_key(scene_key)
	var loader = ResourceLoader.load_threaded_request(scene_path)
	if not ResourceLoader.exists(scene_path) or loader == null:
		return
		
	next_scene = scene_path
	_load_progress_timer = Timer.new()
	_load_progress_timer.wait_time = 0.1
	_load_progress_timer.timeout.connect(monitor_load_status)
	_load_progress_timer.autostart = true
	get_tree().root.add_child.call_deferred(_load_progress_timer)
	
func monitor_load_status() -> void:
	var progress = []
	var load_status = ResourceLoader.load_threaded_get_status(next_scene, progress)
	
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			_load_progress_timer.stop()
			return
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			print('loading')
		ResourceLoader.THREAD_LOAD_FAILED:
			print('load failed')
		ResourceLoader.THREAD_LOAD_LOADED:
			_load_progress_timer.stop()
			_load_progress_timer.queue_free()
			scene_finished_loading.emit(ResourceLoader.load_threaded_get(next_scene).instantiate())
			
func next_scene_loaded(new_scene) -> void:
	clear_current_scene()
	current_scene.call_deferred("add_child", new_scene)
	
func clear_current_scene() -> void:
	for child in current_scene.get_children():
		child.queue_free()
