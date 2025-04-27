# Advanced Usage of Custom Resources

## Basic Concept

We want to have an ability resource that basically holds a variety of scenes. By defining them as export variables, and defining methods that load/use those scenes we can ensure that any custom created abilities can interact with our game world, store screen, and any other custom scene properly without issue.

We're also going to be passing context between our scenes via an additional params field that can contain key/value pairs to the various game systems we want to have interacting with each other.

There might be an argument for creating a custom resource instead to pass around. Maybe in a more established game where we don't want to deal with potentially missing keys and dictionary lookup errors.

## Project Setup

The project is going to have 4 basic components:

1. `assets` 
2. `base_scene` - Holds the scene data for our base game
3. `special_abilities` - Holds all the ability data (including our base ability class)
4. `store_scene` - Holds the scene data for a store screen, which is separate from our base scene.

## Creating a modular resource

```
base_special_ability.gd

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

func connect_active_signal(parent_callable: Callable):
	if game_scene:
		game_scene._connect_parent_signal(parent_callable)
	else:
		print("Game scene not initialized")
	
func connect_interact_with_tilemap(parent_callable: Callable):
	if game_scene:
		game_scene._connect_interact_tilemap_signal(parent_callable)
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
4. `connect_interact_with_tilemap` - This connects the ability to interact with the tilemap to the sub-ability (In this case, all the interact is doing is setting the tile from green to red).
5. `use_ability` - This is the actual method that executes whatever actions have been set on the sub-scene. However it affects the board state, it should be reflected here. If there are additional paramters we need to send (e.g. the tilemap layer) we send it through the params dictionary.

### The Game Scene Script

In our base example above, we set aside a contract that our sub abilities should follow when they're instantiated into the scene. Lets look at the sub-scene script:

```
straight_line_ability_scene.gd

extends Node2D

@onready var arrow_texture := %ArrowTexture
@onready var movement_cd := %MovementCD

var placement_coord: Vector2i
var direction_keys := [Vector2i(-1,0),Vector2i(0,-1),Vector2i(1,0),Vector2i(0,1)]
var direction := 0
var preview: Sprite2D
var placing_ability: bool = false
var is_placed: bool = false
var tilemaplayer: TileMapLayer
var tilemap_dimensions := Vector2i(5,5)

signal placed_on_board
signal interact_with_board

func _ready():
	preview = arrow_texture
	preview.modulate.a = 0.5 ## Semi-transparent

func _process(_delta):
	if placed_on_board.has_connections():
		if placing_ability:
			var mouse_pos := get_local_mouse_position()
			var tilemap_coord = tilemaplayer.local_to_map(get_local_mouse_position())
			preview.position = tilemap_coord*8 + Vector2i(4, 4) ## Necessary to conform to grid and snap preview to it
			preview.visible = true
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				place_ability()
				_relinquish_priority()
			if Input.is_action_just_pressed("rotate_ninety"):
				preview.rotate(deg_to_rad(90))
				_rotate(0)
			if Input.is_action_just_pressed("rotate_neg_ninety"):
				preview.rotate(deg_to_rad(-90.0))
				_rotate(1)
		if is_placed:
			pass
	else:
		print("Error: signal was never connected back to parent")

func place_ability():
	_map_tilemap_coord_and_interact()
	movement_cd.start()

func use_ability(params: Dictionary):
	## if the parameters contains the tilemaplayer, lets set a reference to it
	if params.has("tilemaplayer"):
		tilemaplayer = params["tilemaplayer"]
	_set_active_scene()	
	
func _connect_parent_signal(parent_callable: Callable):
	placed_on_board.connect(parent_callable)

func _connect_interact_tilemap_signal(parent_callable: Callable):
	interact_with_board.connect(parent_callable)
	
func _set_active_scene():
	placing_ability = true
	
func _relinquish_priority():
	preview.modulate.a = 1.0
	placing_ability = false
	placed_on_board.emit()
	
func _rotate(rot_dir: int): ## 0 = 90, 1 = -90 degrees
	match rot_dir:
		0:
			direction = direction + 1 if direction < direction_keys.size() - 1 else 0
		1:
			direction = direction - 1 if direction > 0 else direction_keys.size() - 1

func _on_movement_cd_timeout():
	var curr_pos := preview.position
	preview.position = Vector2i(curr_pos.x, curr_pos.y) + Vector2i(8, 8) * direction_keys[direction]
	_map_tilemap_coord_and_interact()

func _map_tilemap_coord_and_interact():
	var tilemap_coord := tilemaplayer.local_to_map(preview.position)
	if tilemap_coord.x in range(0, tilemap_dimensions.x) and tilemap_coord.y in range(0, tilemap_dimensions.y):
		interact_with_board.emit(tilemap_coord)
	else:
		self.queue_free()
```

The above code is relatively simple. Lets break down the bits and pieces:
	
`_process()` has a check to make sure that our sub-ability has been connected to something. The signal `placed_on_board` is important because it lets us pass priority back to the parent scene, so having that connected is important to the overall scene.

Additionally, a flag `placing_ability` lets us know that the user is actively in the sub-scene and attempting to place an ability. It's here we allow the rotation of the ability, and various other helper methods (for capturing the nearest tile to the mouse location, and the direction the ability is facing).

The helper methods: `_rotate()`, `_map_tilemap_coord_and_interact()`, and `_on_movement_cd_timeout()` are all functions that helps our sub-ability interact with the board and render correctly.

#### Decoupling the code 

 `_connect_parent_signal()` and `_connect_interact_tilemap_signal()` are important tidbits in this bit of code. Because our base resource (`base_special_ability.gd`) isn't the same as our child sub-ability (`straight_line_ability`) we can't actually have the sub-ability inherit from the base class, this is why having the contract specified in the base special ability resource is so important: It defines the contract that all our sub-abilities must follow.

To take this further, we could have the base special ability instead take another custom resource, this time one that abstracts out the straight line ability script to even further ensure we decouple our code.

The reason this is important to implement correctly is that we want to eventually ensure that all abilities can be invoked via filepath dynamically as the player picks up and activates certain powers. We don't want everything loaded in at once, and want to de-load abilities that the user will never use.

By creating an interface, we can easily create new abilities and simply have them plug and play into the existing code.
