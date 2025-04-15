extends Resource

"""
The special ability resource needs to hold a couple of things:

1. Multiple scenes that can be instantiated. In our case we want to hold things like a shop scene,
an in-game scene, maybe an ability bar scene as well.
2. Base ability stats, containing the numbers specific to said ability (cd and damage maybe)
3. Scripts within the ability that lets players utilize it (should be shared among all base special 
abilities to ensure that it is as modular as possible.)
"""

@export var store_scene: PackedScene
@export var game_scene: PackedScene

@export var name: String
@export var is_consumable: bool
@export var description: String

"""
Load the base scene into the game.
"""
func load_base_scene(parent_node: Variant):
	var new_scene := game_scene.instantiate()
	## We can do some initial seeding here if needed
	## new_scene.set_some_variable = something
	parent_node.add_child(new_scene)

"""
Load the store scene into the game.
"""
func load_store_scene(parent_node: Variant):
	var new_scene := store_scene.instantiate()
	parent_node.add_child(new_scene)

"""
Empty contract to allow abilities to implement their own sub use-ability method.
"""
func use_ability(params: Dictionary):
	pass
	
