# Advanced Usage of Custom Resources

## TODO:

Implement the sub-scene's special ability (arrow that can rotate and move forward in the selected direction, turning green tiles into red tiles until it runs out of bounds).

Additionally, we need to handle queueing the resource free once it's completed its action (any persistent actions should technically be left on the parent board state, allowing us to delete and recreate the sub-scene at will).

## Basic Concept

We want to have an ability resource that basically holds a variety of scenes. By defining them as export variables, and defining methods that load/use those scenes we can ensure that any custom created abilities can interact with our game world, store screen, and any other custom scene properly without issue.

## Project Setup

The project is going to have 4 basic components:

1. `assets`
2.`base_scene` - Holds the scene data for our base game
3. `special_abilities` - Holds all the ability data (including our base ability class)
4. `store_scene` - Holds the scene data for a store screen, which is separate from our base scene.

## Creating a modular resource

```
class_name BaseSpecialAbility
extends Resource

@export var store_scene_resource: PackedScene
@export var game_scene_resource: PackedScene

@export var name: String
@export var is_consumable: bool
@export var description: String

var game_scene: Node
var store_scene: Node

func create_base_scene():
	var new_scene := game_scene_resource.instantiate()
	game_scene = new_scene
	
## Allows us to pass priority between parent and sub-scenes
func connect_active_signal(parent_callable: Callable):
	if game_scene:
		game_scene._connect_parent_signal(parent_callable)
	else:
		print("Game scene not initialized")

func add_base_scene(parent_node: Node):
	if game_scene:
		parent_node.add_child(game_scene)
	else:
		print("Game scene not initialized")
	
func load_store_scene():
	...

func add_store_scene(parent_node: Node):
	...

func use_ability(params := {}) -> void:
	if game_scene.has_method("use_ability"):
		game_scene.use_ability(params)
	else:
		print("No method found, exiting")
```

The above code is a resource that holds everything related to the special ability. The game scene is the scene that should be spawned when we create this special sub ability (its icons, the way it interacts with the board, how it takes priority over the base scene etc...)

For now, the store scene code is ignored, but we added 4 important functions that allows our base game to interact with this new sub-scene.

1. `create_base_scene` - Which instantiates this ability (we can choose to selectively instantiate it, if the player doesn't have this ability unlocked no need to load it into resources)
2. `connect_active_signal` - This is a function that should be called after we add the scene into the tree, its goal is to connect a signal in our sub-scene back to the parent scene so we can pass priority back when needed.
3. `add_base_scene` - This takes the resource we've instantiated, and adds it as a child to the specified parent node into the scene tree.
4. `use_ability` - This is the actual method that executes whatever actions have been set on the sub-scene. However it affects the board state, it should be reflected here. If there are additional paramters we need to send (e.g. the tilemap layer) we send it through the params dictionary.

### The Game Scene Script

In our base example above, we set aside a contract that our sub abilities should follow when they're instantiated into the scene. Lets look at the sub-scene script:

```
extends Node2D

@onready var arrow_texture := %ArrowTexture

var placement_coord: Vector2i
var direction: Vector2i
var preview: Sprite2D

var placing_ability: bool = false
signal is_placed

func _ready():
	preview = arrow_texture
	preview.modulate.a = 0.5 ## Semi-transparent

func _process(_delta):
	if is_placed.has_connections():
		if placing_ability:
			var mouse_pos := get_local_mouse_position()
			preview.position = mouse_pos
			preview.visible = true
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				_relinquish_priority()
	else:
		print("Error: signal was never connected back to parent")

func _connect_parent_signal(parent_callable: Callable):
	is_placed.connect(parent_callable)

func use_ability(params: Dictionary):
	_set_active_scene()
	...

func _set_active_scene():
	placing_ability = true
	...

func _relinquish_priority():
	preview.modulate.a = 1.0
	placing_ability = false
	is_placed.emit()
```

The code is relatively simple, and the `use_ability` function has a set of `...` where we would expect our actual ability logic to go. The `_process()` function simply checks A). has the parent signal been connected, and B). are we currently placing this scene.

You can see the moment we trigger the `MOUSE_BUTTON_LEFT` we exit out of our current scene by calling `_relinquish_priority()` which ensures that all the necessary flags are turned off, and the signal to set the main scene as active is emitted.
