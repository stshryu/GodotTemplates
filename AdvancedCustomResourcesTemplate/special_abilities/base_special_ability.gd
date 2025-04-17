class_name BaseSpecialAbility
extends Resource

"""
The special ability resource needs to hold a couple of things:

1. Multiple scenes that can be instantiated. In our case we want to hold things like a shop scene,
an in-game scene, maybe an ability bar scene as well.
2. Base ability stats, containing the numbers specific to said ability (cd and damage maybe)
3. Scripts within the ability that lets players utilize it (should be shared among all base special 
abilities to ensure that it is as modular as possible.)
"""

@export var store_scene_resource: PackedScene
@export var game_scene_resource: PackedScene

@export var name: String
@export var is_consumable: bool
@export var description: String

var game_scene: Node
var store_scene: Node

"""
Game scene methods
"""
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
	
"""
Store scene methods
"""
func load_store_scene():
	var new_scene := store_scene_resource.instantiate()
	store_scene = new_scene

func add_store_scene(parent_node: Node):
	if store_scene:
		parent_node.add_child(store_scene)
	else:
		print("Store scene not initialized")

"""
Executes the base scene use_ability() method alongside additional parameters if supplied.
"""
func use_ability(params := {}) -> void:
	if game_scene.has_method("use_ability"):
		game_scene.use_ability(params)
	else:
		print("No method found, exiting")
