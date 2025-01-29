extends Area2D

@export var upgrade_label: Label
@export var sprite: Sprite2D
@export var ammo_strategy : BaseAmmoStrategy

func _ready() -> void:
	body_entered.connect(on_body_entered)
	upgrade_label.text = ammo_strategy.name

func on_body_entered(body: PhysicsBody2D):
	if body is Player:
		body._upgrade_picked_up(ammo_strategy)
		queue_free()
