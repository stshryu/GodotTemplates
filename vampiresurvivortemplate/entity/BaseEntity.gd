class_name BaseEntity
extends CharacterBody2D

var entity_abilities: Dictionary = {}
var enabled_abilities: Array[String] = []
var ability_node: Node2D

func add_ability_to_entity(new_ability: BaseAbility):
	if !entity_abilities.has(new_ability.ability_name):
		entity_abilities[new_ability.ability_name] = new_ability
		
func enable_ability(ability_name):
	if entity_abilities.has(ability_name) and not enabled_abilities.has(ability_name):
		enabled_abilities.append(ability_name)
	
func disable_ability(ability_name):
	if enabled_abilities.has(ability_name):
		enabled_abilities.remove_at(enabled_abilities.find(ability_name))
		
func create_abilities_in_scene_tree():
	for ability in enabled_abilities:
		var ability_scene = entity_abilities[ability].ability_scene
		ability_scene.instantiate()
		ability_node.call_deferred("add_child", ability_scene)
