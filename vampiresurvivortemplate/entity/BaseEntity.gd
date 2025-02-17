class_name BaseEntity
extends CharacterBody2D

var entity_abilities: Dictionary = {}
var enabled_abilities: Array[String] = []

func add_ability_to_entity(new_ability: ability_scene_resource):
	var ability_name = new_ability.ability_name
	var ability_scene = new_ability.ability_scene
	entity_abilities[ability_name] = ability_scene
	
func enable_ability(ability_name):
	pass
	
func disable_ability(ability_name):
	pass
		
func create_abilities_in_scene_tree(ability_node):
	pass
