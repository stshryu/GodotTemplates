extends Area2D

@export var overworld_ability_name: RichTextLabel
@export var overworld_ability_sprite: Sprite2D
@export var ability: ability_scene_resource

func _ready():
	overworld_ability_name.text = ability.ability_name
	overworld_ability_sprite.texture = ability.overworld_ability_texture
	body_entered.connect(on_body_entered)
	
func on_body_entered(body: PhysicsBody2D):
	if body is Player:
		body.add_ability_to_entity(ability)
		queue_free()
