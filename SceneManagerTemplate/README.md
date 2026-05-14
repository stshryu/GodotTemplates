# Scene Manager Template

This project is a baseline implementation of a scene manager that will handle everything from loading, unloading and transitioning between scenes.

## Project Layout

`scene_manager/` - This folder should contain the root scene, and the corresponding gd script file that houses the logic for our scene logic.

`interface/` - Contains two dummy scenes that we will use to demonstrate loading and unloading scenes (`main_menu` and `other_scene`)

`utils/` - Contains the singleton method that will return the root SceneManager node.

## SceneManager Script

The start of the script is pretty straightforward, we'll create a SceneManager `class_name` and have it extend from a Node2D base class.

This scene root should look something like this:
- SceneManager (Node2D)
-- CurrentScene (Node2D)

The script should look like the block of code below. It instantiates all the basic things we want for this manager. The `scenes` dictionary holds the direct pathways to all of our scenes (if you want to dynamically load file references, that path should go here).

```
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
```

Next lets define our `_ready()` function for when this scene is loaded up for the first time. 

We want to make sure that we move the current scene's position into the center of the screen. If you want custom settings for viewports, this is the place to put that code.

We also want to connect the signals that will let our script know that scenes are finished loading.

The final line loads our initial scene, for me I've set it to be a main menu, but if you want a splash scene or title screen you can include that here.

```
func _ready():
	current_scene.position = get_viewport_rect().size / 2.0
	
	scene_finished_loading.connect(next_scene_loaded)
	
	load_scene("main_menu")
```

Helper functions should be defined to allow us to fetch scenes via methods. The only public functions should be `get_path_from_key()` and `load_scene()`

```
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
```

## Utils

Another important feature of this scene manager is how easily it can be accessed from the rest of your scenes.

Inside the utils folder we'll create a simple autoload script (autoloads are singletons instantiated at game runtime that can be accessed from any child scene)

In order to autoload the script, click on `Project Settings -> Globals -> Autoload` tab and fill in the folder/script you want to autoload.

```
extends Node

func get_scene_manager() -> SceneManager:
	return get_node("/root/SceneManager")
```

The code above means any child scene can call `Utils.get_scene_manager()` to return the scene manager root node, so we can call `scene_manager.load_scene('...')`.
