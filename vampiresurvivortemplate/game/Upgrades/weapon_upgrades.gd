extends Area2D

@export var upgrade_name: String
@export var upgrade_label: Label
@export var sprite: Sprite2D
@export var weapon_strategy: BaseWeaponStrategy

func _ready() -> void:
	body_entered.connect(on_body_entered)
	sprite.texture = weapon_strategy.texture
	upgrade_label.text = weapon_strategy.name

func on_body_entered(body: PhysicsBody2D):
	if body is Player:
		body._weapon_upgrade_picked_up(weapon_strategy)
		queue_free()
